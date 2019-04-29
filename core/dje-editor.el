

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; autosave the undo-tree hisotry
(setq unto-tree-history-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq undo-tree-auto-save-history t)

;; tab behavior - indent or complete
(setq tab-always-indent 'complete)

(require 'diminish)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; undo-tree
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face tabs empty trailing lines-tail))

(provide 'dje-editor)
