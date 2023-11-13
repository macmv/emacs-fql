; === Setup for the FQL filetype, or "major mode" as emacs calls it.

(load! "fql-mode-syntax.el")
(load! "fql-mode-font-lock.el")

(defgroup fql nil
  "A programming mode FQL"
  :group 'languages)

(define-derived-mode fql-mode prog-mode "FQL"
  "Major mode for editing FQL."

  (setq font-lock-defaults '(fql-font-lock:setup nil)))

; Attach .fql files to fql-mode
;;;###autoload
(progn
  (add-to-list 'auto-mode-alist
               '("\\.fql\\'" . fql-mode))
  (modify-coding-system-alist 'file "\\.fql\\'" 'utf-8))

(provide 'fql-mode)
