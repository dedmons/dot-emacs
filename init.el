(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(ledger-mode neotree magit)
  "List of packages to have installed")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; load init files
(defvar emacs-dir (file-name-directory load-file-name)
  "top level emacs dir")
(defvar module-dir (concat emacs-dir "modules/")
  "My emacs configs")

;; Add to load path
(add-to-list 'load-path module-dir)

;; Load all .el file in each folder of load-path
(mapc 'load (directory-files module-dir nil "^[^#].*el$"))


;; Generated crap
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )