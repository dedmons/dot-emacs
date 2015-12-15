(mapc
 '(lambda (path)
    (push (expand-file-name path user-emacs-directory) load-path))
 '("lisp" "lisp/use-package" "modules"))

(require 'package)
(require 'cl)

(require 'use-package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; load init files
(defvar dje/module-dir (expand-file-name "modules/" user-emacs-directory)
  "My emacs configs")

;; Load all .el file in module-dir
(mapc 'load-file (directory-files dje/module-dir t "^[^#].*el$"))
