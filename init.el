;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2022 DJ Edmonson
;;
;; Author: DJ Edmonson
;; URL: https://github.com/dedmons/djemacs
;; Version: 0.1.0

;;; Commentary:

;; This file sets up general load and configuration paths
;; as well as loads various module and config files.

;;; License:


;;; Code:

(defconst emacs-start-time (current-time))
(unless noninteractive
  (message "Loading %s..." load-file-name))

;; Always load newest byte code
(setq load-prefer-newer t)

(defvar config-dir (file-name-directory load-file-name)
  "Root dir of the Emacs config")
(defvar dje-core-dir (expand-file-name "core" config-dir)
  "Main configuration files")
(defvar dje-modules-dir (expand-file-name "modules" config-dir)
  "Configuration modules, typically for specific modes or packages")
(defvar dje-vendor-dir (expand-file-name "vendor" config-dir)
  "This folder holdes packages that are not on ELPA or MELPA")
(defvar dje-savefile-dir (expand-file-name "savefiles" config-dir)
  "This folder holds all the generated save/hisotry files")

(unless (file-exists-p dje-savefile-dir)
  (make-directory dje-savefile-dir))

(defun dje/add-subfolders-to-load-path (parent-dir)
  "Add all subdirs of PARENT-DIR to the `load-path'"
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (add-to-list 'load-path name)
        (dje/add-subfolders-to-load-path name)))))

(add-to-list 'load-path dje-core-dir)
(add-to-list 'load-path dje-modules-dir)
(add-to-list 'load-path dje-vendor-dir)
(dje-add-subfolders-to-load-path dje-vendor-dir)

;; reduce the frequency of garbage collection from .76MB to 50MB
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Load core configs
(require 'dje-packages)
(require 'dje-custom)
(require 'dje-ui)
(require 'dje-editor)

;; macOS specific settings
(when (eq system-type 'darwin)
  (require 'dje-macos))

(when (eq system-type 'gnu/linux)
  (require 'dje-linux))

(when (eq system-type 'windows-nt)
  (require 'dje-windows))

;; Load modules file
(if (file-exists-p dje-modules-file)
    (load dje-modules-file))

;; Load all .el file in module-dir
(mapc 'load-file (directory-files dje-module-dir t "^[^#].*el$"))

(setq custom-file (expand-file-name "custom.el" config-dir))

(when window-system
  (let ((elapsed (float-time (time-subtract (current-time)
                                            emacs-start-time))))
    (message "Loading %s...done (%.3fs)" load-file-name elapsed))

  (add-hook 'after-init-hook
            `(lambda ()
               (let ((elapsed (float-time (time-subtract (current-time)
                                                         emacs-start-time))))
                 (message "Loading %s...done (%.3fs) [after-init]"
                          ,load-file-name elapsed)))
            t))

;;; init.el ends here
