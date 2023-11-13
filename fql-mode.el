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

(defun fql-re-word (inner) (concat "\\<" inner "\\>"))
(defun fql-re-grab (inner) (concat "\\(" inner "\\)"))
(defun fql-re-shy (inner) (concat "\\(?:" inner "\\)"))

(defconst fql-re-ident "[[:word:][:multibyte:]_][[:word:][:multibyte:]_[:digit:]]*")

(defvar fql-font-lock-keywords
  `(
    ; Keywords proper
    (,(regexp-opt fql-keywords 'symbols) . font-lock-keyword-face)

    ; Modules
    (,(regexp-opt fql-modules 'symbols) . font-lock-constant-face)

    ; TODO: Need this for @role in FSL
    ;;; Attributes like `#[bar(baz)]` or `#![bar(baz)]` or `#[bar = "baz"]`
    ;(,(rust-re-grab (concat "#\\!?\\[" rust-re-ident "[^]]*\\]"))
    ; 1 font-lock-preprocessor-face keep)

    ;; Field names like `foo:`, highlight excluding the :
    (,(concat (fql-re-grab fql-re-ident) "[[:space:]]*:[^:]")
     1 font-lock-variable-name-face)

    ;;; CamelCase Means Type Or Constructor
    ;(,rust-re-type-or-constructor 1 font-lock-type-face)

    ;;; Type-inferred binding
    ;(,(concat "\\_<\\(?:let\\s-+ref\\|let\\|ref\\|for\\)\\s-+\\(?:mut\\s-+\\)?"
    ;          (rust-re-grab rust-re-ident)
    ;          "\\_>")
    ; 1 font-lock-variable-name-face)

   ; TODO: Need this for FSL
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
