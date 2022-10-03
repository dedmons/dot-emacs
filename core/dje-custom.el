;;; dje-custom.el --- DJEmacs customizable variables
;;
;; Copyright © 2022 DJ Edmonson
;;
;; Author: DJ Edmonson
;; URL: https://github.com/dedmons/djemacs

;;; Commentary:

;; Some Linux specific stuff.

;;; License:


;;; Code:

(defgroup dje nil
  "DJEmacs configuration"
  :prefix "dje-"
  :group 'convenience)

(defcustom dje-auto-save t
  "Non-nil values enable auto save."
  :type 'boolean
  :group 'dje)

(defcustom dje-whitespace t
  "Non-nil values enable whitespace visualization."
  :type 'boolean
  :group 'dje)

(defcustom dje-clean-whitespace-on-save t
  "cleanup whitespace from file before its saved.
Will only occur if `dje-whitespace' is also enabled."
  :type 'boolean
  :group 'dje)

(defcustom dje-theme 'zenburn
  "The default color theme"
  :type 'symbol
  :group 'dje)

(provide 'dje-custom)
;;; dje-custom.el ends here
