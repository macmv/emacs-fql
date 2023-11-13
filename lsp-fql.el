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
  'node
  `(:system "node"))

(lsp-dependency
  'fql-analyzer
  `(:download :url "https://static-assets.fauna.com/fql-analyzer/index.js"
              :store-path lsp-fql-analyzer-store-path
              :set-executable? t))

; foo '(:system "node")


; Start fql-analyzer with `node fql-analyzer.js --stdio`
(defun lsp-fql-analyzer-command ()
  `(,(lsp-package-path 'node), lsp-fql-analyzer-store-path, "--stdio"))

; This maps fql-mode to the language "fql", which is used below in :activation-fn
(add-to-list 'lsp-language-id-configuration '(fql-mode . "fql"))

; Actually sets up the fql-analyzer server.
(lsp-register-client
 (make-lsp-client
   :new-connection (lsp-stdio-connection 'lsp-fql-analyzer-command)
   :activation-fn (lsp-activate-on "fql")
   :priority -1
   :server-id 'fql-analyzer
   ; fql-analyzer only supports completions as of writing, so we don't need any of these.
   ;:initialization-options '((decorationProvider . t)
   ;                          (inlineDecorationProvider . t)
   ;                          (didFocusProvider . t))

   ; TODO
   ;:initialized-fn (lambda (workspace)
   ;                  (lsp-fql-set-secret))

   ; this actually goes and downlaods the :download dependency above
   :download-server-fn (lambda (_client callback error-callback _update?)
                         (lsp-package-ensure 'node callback error-callback)
                         (lsp-package-ensure 'fql-analyzer callback error-callback))))

(provide 'lsp-fql)
