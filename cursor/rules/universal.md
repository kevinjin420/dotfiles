## 1. Documentation & Comments
* **Minimalism First:** Provide minimal and concise comments. 
* **Self-Documenting Code:** If the logic is simple and easily understood, do not provide comments unless explicitly requested.
* **Focus on "Why":** Use comments only to explain non-obvious business logic, technical debt, or complex algorithms. Do not describe "what" the code is doing if it is self-evident.
* **No "Vibe-Coding":** Avoid redundant restatements of function names or basic syntax.
* **No Emojis:** Do not use emojis anywhere in the code, comments, or documentation.
* **No Em-dashes:** Use standard punctuation only; avoid the use of em-dashes (—).

## 2. Logic & Architecture
* **Prioritize Correctness:** Do not sacrifice error handling or type safety for conciseness.
* **Defensive Programming:** Always implement input validation and explicit error boundaries.
* **State Management:** Be explicit about state transitions. Avoid side effects in pure functions.
* **No Placeholders:** Provide functional, executable code. Do not use `// implement logic here` or `...rest of code`.

## 3. Style & Patterns
* **Explicit over Implicit:** Avoid "magic" syntax or clever one-liners that obscure intent.
* **Type Strictness:** In TypeScript, avoid `any`. Define interfaces for all data shapes. Use `unknown` and narrow types when the shape is not immediately certain.
* **Naming:** Use domain-specific, descriptive nouns. Avoid generic names like `data`, `info`, or `handleResult`.

## 4. Refactoring & Iteration
* **Edge Case Validation:** Mentally execute logic against null values, empty arrays, and timeouts before finalizing.
* **Boring Code:** Aim for code that is predictable, robust, and easy to maintain.
