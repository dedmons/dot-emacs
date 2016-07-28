(use-package color-theme
             :if window-system
             :ensure t)

(use-package color-theme-solarized
             :if window-system
             :ensure t
             :init
             (set-frame-parameter nil 'background-mode 'dark)
             (message "Color Theme Init")
             :config
             (message "Color Theme Config")
             (load-theme 'solarized t))

