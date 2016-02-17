(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

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

(use-package yasnippet
  :ensure t
  :config
  (add-to-list 'yas/root-directory "~/.emacs.d/snippets")
  (yas-global-mode 1))
