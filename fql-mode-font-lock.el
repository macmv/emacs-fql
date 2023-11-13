
(defun fql-font-lock:setup ()
  `(;; keywords
    (,fql-syntax:modules-re 2 font-lock-constant-face)

    ; line comments
    (,fql-syntax:comment-re 2 font-lock-comment-face)
  ))

(provide 'fql-mode-font-lock)
