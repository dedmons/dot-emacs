(require 'company)

(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'company-backends 'company-ghc)
(custom-set-variables
  '(company-ghc-show-info t))
