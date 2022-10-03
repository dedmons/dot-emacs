;;; dje-linux.el --- DJEmacs linux specific config
;;
;; Copyright © 2022 DJ Edmonson
;;
;; Author: DJ Edmonson
;; URL: https://github.com/dedmons/djemacs

;;; Commentary:

;; Some Linux specific stuff.

;;; License:


;;; Code:

(prelude-require-packages '(exec-path-from-shell))

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(provide 'dje-linux)
;;; dje-linux.el ends here
