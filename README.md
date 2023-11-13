# Installation

I use doom emacs, so this is what's required for that. I think the following can
be adapted for other plugin systems, but I haven't looked into that.

Add the plugin to `packages.el`:
```elisp
(package! fql :recipe (:host github :repo "macmv/emacs-fql"))
```

Then, enable the package in `config.el`:
```elisp
(use-package! fql)
(add-hook 'fql-mode-hook #'lsp)
```

Then, you need to install the fql-analyzer server by running
`M-x lsp-install-server` and selecting `fql-analyzer`.

Once its installed, open an FQL file and autocompletions should work.

fql-analyzer will connect to `localhost:8443` with the secret `secret`, which is
hardcoded for now. This can be changed by modifying the function
`lsp-fql-set-secret`, which is defined in `lsp-fql.el`.
