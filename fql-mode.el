; === Setup for the FQL filetype, or "major mode" as emacs calls it.

(define-derived-mode fql-mode prog-mode "FQL"
  "Major mode for editing FQL."

  ; TODO
  ;:syntax-table fql-syntax:syntax-table

  ;(fql-mode:make-local-variables
  ; 'syntax-propertize-function
  ; 'font-lock-syntactic-face-function
  ; 'font-lock-defaults
  ; 'paragraph-start
  ; 'paragraph-separate
  ; 'parse-sexp-lookup-properties
  ; 'fill-paragraph-function
  ; 'adaptive-fill-function
  ; 'adaptive-fill-regexp
  ; 'adaptive-fill-first-line-regexp
  ; 'comment-start
  ; 'comment-end
  ; 'comment-start-skip
  ; 'comment-column
  ; 'comment-multi-line
  ; 'forward-sexp-function
  ; 'find-tag-default-function
  ; 'indent-line-function
  ; 'fixup-whitespace
  ; 'delete-indentation
  ; 'indent-tabs-mode
  ; 'imenu-create-index-function
  ; 'beginning-of-defun-function
  ; 'end-of-defun-function)

  ;(setq fql-mode:debug-messages       nil
  ;  syntax-propertize-function      'fql-syntax:propertize
  ;  parse-sexp-lookup-properties    t

  ;  ;; comments
  ;  paragraph-start                 fql-paragraph:paragraph-start-re
  ;  paragraph-separate              fql-paragraph:paragraph-separate-re
  ;  fill-paragraph-function         'fql-paragraph:fill-paragraph
  ;  adaptive-fill-function          'fql-paragraph:fill-function
  ;  adaptive-fill-regexp            "[ \t]*\\(//+[ \t]*\\)*"
  ;  adaptive-fill-first-line-regexp fql-paragraph:fill-first-line-re
  ;  comment-start                   "// "
  ;  comment-end                     ""
  ;  comment-start-skip              "\\(//+\\|/\\*+\\)[ \t]*"
  ;  comment-column                  0
  ;  comment-multi-line              t

  ;  forward-sexp-function           'fql-mode:forward-sexp-function
  ;  find-tag-default-function       'fql-mode:find-tag
  ;  indent-line-function            'fql-indent:indent-line
  ;  fixup-whitespace                'fql-indent:fixup-whitespace
  ;  delete-indentation              'fql-indent:join-line
  ;  indent-tabs-mode                nil
  ;  beginning-of-defun-function     #'fql-syntax:beginning-of-definition
  ;  end-of-defun-function           #'fql-syntax:end-of-definition
  ;  imenu-create-index-function     #'fql-imenu:create-imenu-index)

  ;(use-local-map fql-mode-map)
  )

; Attach .fql files to fql-mode
;;;###autoload
(progn
  (add-to-list 'auto-mode-alist
               '("\\.fql\\'" . fql-mode))
  (modify-coding-system-alist 'file "\\.fql\\'" 'utf-8))

(provide 'fql-mode)
