;; Some macOS specific things

;; On macOS Emacs doesn't use the shell PATH if it's not started from
;; the shell. Let's fix that:
(dje-require-packages '(exec-path-from-shell))

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; CMD is Meta, ALT is Super
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(provide 'dje-macos)
