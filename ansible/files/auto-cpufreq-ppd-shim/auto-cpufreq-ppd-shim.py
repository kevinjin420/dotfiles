#!/usr/bin/env python3
# Translates org.freedesktop.UPower.PowerProfiles into auto-cpufreq --force,
# so KDE's popup works again without a second daemon fighting for the governor.
import pickle
import subprocess
from pathlib import Path

import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib

IFACE = "org.freedesktop.UPower.PowerProfiles"
OBJECT_PATH = "/org/freedesktop/UPower/PowerProfiles"
OVERRIDE_STATE = Path("/opt/auto-cpufreq/override.pickle")

PROFILE_TO_FORCE = {
    "performance": "performance",
    "power-saver": "powersave",
    "balanced": "reset",
}
FORCE_TO_PROFILE = {"performance": "performance", "powersave": "power-saver"}


def current_profile() -> str:
    if not OVERRIDE_STATE.is_file():
        return "balanced"
    with open(OVERRIDE_STATE, "rb") as store:
        override = pickle.load(store)
    return FORCE_TO_PROFILE.get(override, "balanced")


class PowerProfilesShim(dbus.service.Object):
    def __init__(self, bus: dbus.Bus, bus_name: dbus.service.BusName) -> None:
        super().__init__(bus, OBJECT_PATH, bus_name)

    @dbus.service.method("org.freedesktop.DBus.Properties", in_signature="ss", out_signature="v")
    def Get(self, interface: str, prop: str) -> dbus.String:
        return self.GetAll(interface)[prop]

    @dbus.service.method("org.freedesktop.DBus.Properties", in_signature="s", out_signature="a{sv}")
    def GetAll(self, interface: str) -> dbus.Dictionary:
        return dbus.Dictionary(
            {
                "ActiveProfile": current_profile(),
                "Profiles": dbus.Array(
                    [
                        dbus.Dictionary({"Profile": p, "Driver": "auto-cpufreq"}, signature="sv")
                        for p in ("power-saver", "balanced", "performance")
                    ],
                    signature="a{sv}",
                ),
                "Actions": dbus.Array([], signature="s"),
                "ActiveProfileHolds": dbus.Array([], signature="a{sv}"),
                "PerformanceInhibited": "",
                "PerformanceDegraded": "",
            },
            signature="sv",
        )

    @dbus.service.method("org.freedesktop.DBus.Properties", in_signature="ssv")
    def Set(self, interface: str, prop: str, value: str) -> None:
        if prop != "ActiveProfile":
            return
        force = PROFILE_TO_FORCE.get(str(value))
        if force is None:
            return
        subprocess.run(["auto-cpufreq", f"--force={force}"], check=False)
        self.PropertiesChanged(IFACE, {"ActiveProfile": str(value)}, [])

    @dbus.service.signal("org.freedesktop.DBus.Properties", signature="sa{sv}as")
    def PropertiesChanged(self, interface: str, changed: dict, invalidated: list) -> None:
        pass

    @dbus.service.method(IFACE, in_signature="sss", out_signature="u")
    def HoldProfile(self, profile: str, reason: str, application_id: str) -> int:
        return 0

    @dbus.service.method(IFACE, in_signature="u")
    def ReleaseProfile(self, cookie: int) -> None:
        pass


def main() -> None:
    DBusGMainLoop(set_as_default=True)
    bus = dbus.SystemBus()
    bus_name = dbus.service.BusName(IFACE, bus)
    PowerProfilesShim(bus, bus_name)
    GLib.MainLoop().run()


if __name__ == "__main__":
    main()
