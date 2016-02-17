(use-package haskell-mode
  :ensure t)

(use-package company-ghci
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (setq haskell-process-type 'stack-ghci)
  (setq haskell-process-path-ghci "stack")
  (setq haskell-process-args-ghci "ghci")

  (require 'company)
  (push 'company-ghci company-backends))

(use-package flycheck
  :ensure t)

(use-package flycheck-haskell
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-haskell-configure))
