;; Disable splash screen
(setq inhibit-splash-screen t)

;; Set custimizations file
(set 'custom-file (expand-file-name "settings.el" user-emacs-directory))
(load custom-file)

;; Set tabs and format stuff
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; Move all autosave file to common directory
(setq backup-directory-alist 
  `(("." . "~/.emacs.d/saves/")))

(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/saves/" t)))

(setq backup-by-copy t)


(use-package fish-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package neotree
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))
