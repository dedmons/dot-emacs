;; General UI configuration

(blink-cursor-mode -1)

(setq ring-bell-function 'ignore)

(setq inhibit-startup-screen t)

(setq scroll-margin 1
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; use configured theme
(when dje-theme
  (load-theme dje-theme t))

;; shows the cursor after big movements in the window
(require 'beacon)
(beacon-mode +1)

;; show available keybinding after you start typing
(require 'which-key)
(which-key-mode +1)

(provide 'dje-ui)
