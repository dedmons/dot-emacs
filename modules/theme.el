(defvar my-theme-package 'color-theme-solarized)
(defvar my-theme 'solarized)

(set-frame-parameter nil 'background-mode 'dark)

(when window-system
    (when (not (package-installed-p my-theme-package))
      (package-install my-theme-package))
    (load-theme 'solarized t)) 
