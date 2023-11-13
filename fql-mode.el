; === Setup for the FQL filetype, or "major mode" as emacs calls it.

(defgroup fql-mode nil
  "A programming mode for FQL"
  :group 'languages)

(defvar fql-mode-syntax-table
  (let ((table (make-syntax-table)))

    ;; Operators
    (dolist (i '(?+ ?- ?* ?/ ?% ?& ?| ?^ ?! ?< ?> ?~ ?@))
      (modify-syntax-entry i "." table))

    ;; Strings
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\\ "\\" table)

    ;; Angle brackets.  We suppress this with syntactic propertization
    ;; when needed
    (modify-syntax-entry ?< "(>" table)
    (modify-syntax-entry ?> ")<" table)

    ;; Comments
    (modify-syntax-entry ?/  ". 124b" table)
    (modify-syntax-entry ?*  ". 23n"  table)
    (modify-syntax-entry ?\n "> b"    table)
    (modify-syntax-entry ?\^m "> b"   table)

    table))

(defconst fql-keywords
  '("let" "at" "if" "else" "isa"))

(defconst fql-modules
  '("Collection" "Function" "Role" "AccessProvider" "Database" "Key"
    "Credential" "Token" "Array" "Boolean" "Date" "Math" "Null"
    "Number" "Int" "Long" "Double" "Float" "Object" "Set"
    "SetCursor" "Struct" "Time" "TransactionTime" "Query"))

(defvar fql-font-lock-keywords
  `(
    ; Keywords proper
    (,(regexp-opt fql-keywords 'symbols) . font-lock-keyword-face)

    ; Modules
    (,(regexp-opt fql-modules 'symbols) . font-lock-constant-face)

    ;;; Contextual keywords
    ;("\\_<\\(default\\)[[:space:]]+fn\\_>" 1 font-lock-keyword-face)
    ;(,rust-re-union 1 font-lock-keyword-face)

    ;;; Special types
    ;(,(regexp-opt rust-special-types 'symbols) . font-lock-type-face)

    ;;; The unsafe keyword
    ;("\\_<unsafe\\_>" . 'rust-unsafe)

    ;;; Attributes like `#[bar(baz)]` or `#![bar(baz)]` or `#[bar = "baz"]`
    ;(,(rust-re-grab (concat "#\\!?\\[" rust-re-ident "[^]]*\\]"))
    ; 1 font-lock-preprocessor-face keep)

    ;;; Builtin formatting macros
    ;(,(concat (rust-re-grab
    ;           (concat (rust-re-word (regexp-opt rust-builtin-formatting-macros))
    ;                   "!"))
    ;          rust-formatting-macro-opening-re
    ;          "\\(?:" rust-start-of-string-re "\\)?")
    ; (1 'rust-builtin-formatting-macro)
    ; (rust-string-interpolation-matcher
    ;  (rust-end-of-string)
    ;  nil
    ;  (0 'rust-string-interpolation t nil)))

    ;;; write! macro
    ;(,(concat (rust-re-grab (concat (rust-re-word "write\\(ln\\)?") "!"))
    ;          rust-formatting-macro-opening-re
    ;          "[[:space:]]*[^\"]+,[[:space:]]*"
    ;          rust-start-of-string-re)
    ; (1 'rust-builtin-formatting-macro)
    ; (rust-string-interpolation-matcher
    ;  (rust-end-of-string)
    ;  nil
    ;  (0 'rust-string-interpolation t nil)))

    ;;; Syntax extension invocations like `foo!`, highlight including the !
    ;(,(concat (rust-re-grab (concat rust-re-ident "!")) "[({[:space:][]")
    ; 1 font-lock-preprocessor-face)

    ;;; Field names like `foo:`, highlight excluding the :
    ;(,(concat (rust-re-grab rust-re-ident) "[[:space:]]*:[^:]")
    ; 1 font-lock-variable-name-face)

    ;;; CamelCase Means Type Or Constructor
    ;(,rust-re-type-or-constructor 1 font-lock-type-face)

    ;;; Type-inferred binding
    ;(,(concat "\\_<\\(?:let\\s-+ref\\|let\\|ref\\|for\\)\\s-+\\(?:mut\\s-+\\)?"
    ;          (rust-re-grab rust-re-ident)
    ;          "\\_>")
    ; 1 font-lock-variable-name-face)

    ;;; Type names like `Foo::`, highlight excluding the ::
    ;(,(rust-path-font-lock-matcher rust-re-uc-ident) 1 font-lock-type-face)

    ;;; Module names like `foo::`, highlight excluding the ::
    ;(,(rust-path-font-lock-matcher rust-re-lc-ident) 1 font-lock-constant-face)

    ;;; Lifetimes like `'foo`
    ;(,(concat "'" (rust-re-grab rust-re-ident) "[^']") 1 font-lock-variable-name-face)

    ;;; Question mark operator
    ;("\\?" . 'rust-question-mark)
    ;("\\(&+\\)\\(?:'\\(?:\\<\\|_\\)\\|\\<\\|[[({:*_|]\\)"
    ; 1 'rust-ampersand-face)
    ;;; Numbers with type suffix
    ;(,rust-number-with-type 1 font-lock-type-face)
    ;)

   ;; Ensure we highlight `Foo` in `struct Foo` as a type.
   ;(mapcar #'(lambda (x)
   ;            (list (rust-re-item-def (car x))
   ;                  1 (cdr x)))
   ;        '(("enum" . font-lock-type-face)
   ;          ("struct" . font-lock-type-face)
   ;          ("union" . font-lock-type-face)
   ;          ("type" . font-lock-type-face)
   ;          ("mod" . font-lock-constant-face)
   ;          ("use" . font-lock-constant-face)
   ;          ("fn" . font-lock-function-name-face)))
   ))


(define-derived-mode fql-mode prog-mode "FQL"
  "Major mode for editing FQL."

  :group 'fql-mode
  :syntax-table fql-mode-syntax-table

  (setq font-lock-defaults '(fql-font-lock-keywords nil)))

; Attach .fql files to fql-mode
;;;###autoload
(progn
  (add-to-list 'auto-mode-alist
               '("\\.fql\\'" . fql-mode))
  (modify-coding-system-alist 'file "\\.fql\\'" 'utf-8))

(provide 'fql-mode)
