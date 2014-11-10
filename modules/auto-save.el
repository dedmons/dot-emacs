;; Move all autosave file to common directory
(setq backup-directory-alist 
  `(("." . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/saves" t)))
(setq backup-by-copy t)
