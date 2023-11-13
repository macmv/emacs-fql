
; All builtin modules
(defconst fql-syntax:modules-unsafe-re
  (regexp-opt '("Collection" "Function" "Role" "AccessProvider" "Database" "Key"
                "Credential" "Token" "Array" "Boolean" "Date" "Math" "Null"
                "Number" "Int" "Long" "Double" "Float" "Object" "Set"
                "SetCursor" "Struct" "Time" "TransactionTime" "Query") 'words))

(defconst fql-syntax:modules-re
  (concat "\\(^\\|[^`'_]\\)\\(" fql-syntax:modules-unsafe-re "\\)"))

(defconst fql-syntax:comment-re "body")

(provide 'fql-mode-syntax)
