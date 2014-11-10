(defvar my-theme-package 'color-theme-solarized)
(defvar my-theme 'solarized-dark)

(when (package-installed-p my-theme-package)
  (if window-system
    (load-theme 'solarized-dark t)))
			  
