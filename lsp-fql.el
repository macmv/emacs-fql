; === Below is the fql-analyzer setup.

(require 'lsp-mode)
(require 'dap-mode)
(require 'lsp-lens)
(require 'view)

(defgroup lsp-fql nil
  "FQL language support, using fql-analyzer."
  :group 'lsp-mode)

(defcustom lsp-fql-analyzer-install-dir
  (f-join lsp-server-install-dir "fql-analyzer/")
  "The installation directory for fql-analzyer."
  :group 'lsp-fql
  :type 'directory)

(defcustom lsp-fql-analyzer-store-path
  (f-join lsp-fql-analyzer-install-dir "fql-analyzer.js")
  "The path where the fql-analyzer JS file is stored."
  :group 'lsp-fql
  :type 'file)

(lsp-dependency
  'fql-analyzer
  `(:system, "node")
  `(:system, lsp-fql-analyzer-store-path))

; Start fql-analyzer with `node fql-analyzer.js --stdio`
(defun lsp-fql-analyzer-command ()
  `(,"node", (lsp-package-path 'fql-analyzer), "--stdio"))

; Downloads fql-analyzer from our static assets URL.
(defun lsp-fql-analyzer-download (_client callback error-callback _update?)
  (call-process
   "wget"
   "https://static-assets.fauna.com/fql-analyzer/index.js"
   "-o"
   "/home/macmv/zzz.js")
  (funcall callback))

; Actually sets up the fql-analyzer server.
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection 'lsp-fql-analyzer-command)
                  :major-modes '(fql-mode)
                  :priority -1
                  ;fql-analyzer only supports completions as of writing, so we don't need any of these.
                  ;:initialization-options '((decorationProvider . t)
                  ;                          (inlineDecorationProvider . t)
                  ;                          (didFocusProvider . t)
                  :initialized-fn (lambda (workspace)
                                    (lsp-fql-set-secret))
                  :server-id 'fql-analyzer
                  :download-server-fn #'lsp-fql-analyzer-download))

(provide 'lsp-fql)
