(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar dje/my-packages '(ledger-mode
                          neotree
                          magit
                          fish-mode
                          haskell-mode
                          ghc
                          shm
                          undo-tree
                          company-ghc)
  "List of packages to have installed")

(defun dje/packages-installed-p ()
  (loop for pkg in dje/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (dje/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg dje/my-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; load init files
(defvar dje/emacs-dir (file-name-directory load-file-name)
  "top level emacs dir")
(defvar dje/module-dir (concat dje/emacs-dir "modules/")
  "My emacs configs")

;; Add to load path
(add-to-list 'load-path dje/module-dir)

;; Load all .el file in each folder of load-path
(mapc 'load (directory-files module-dir nil "^[^#].*el$"))


;; Generated crap
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(safe-local-variable-values
   (quote
    ((haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
