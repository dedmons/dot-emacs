;;; init.el --- DJE's Emacs config
;;
;; Copyright (c) 2022 DJ Edmonson
;;
;; Author: DJ Edmonson
;; URL: https://github.com/dedmons/djemacs
;; Version: 0.1.0

;;; Commentary:

;;
;;

;;; License:

;;; Code:

;; Record start time for loading perf
(defconst emacs-start-time (current-time))
(unless noninteractive
  (message "Loading %s..." load-file-name))

;; Always load newest byte code
(setq load-prefer-newer t)

(defvar config-dir (file-name-directory load-file-name)
  "Root dir for Emacs configuration.")
(defvar dje-savefile-dir (expand-file-name "savefiles" config-dir)
  "Folder to hold all generated save/history files.")

(unless (file-exists-p dje-savefile-dir)
  (make-directory dje-savefile-dir))

;; Reduce the frequency of garbage collection from .76MB to 50MB
(setq gc-cons-threshold 50000000)

;; Warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Set custom file location
(setq custom-file (expand-file-name "custom.el" config-dir))
(load custom-file)

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 2)            ;; but maintain correct appearance

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; General UI tweeks
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(unless (eq system-type 'darwin)
  (menu-bar-mode -1))

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(global-display-line-numbers-mode t)
(global-hl-line-mode t)

(defgroup dje nil
  "DJE Custom Vars."
  :prefix "dje-"
  :group 'convenience)

(defcustom dje-face-height 140
  "Face hight to use."
  :type 'integer
  :group 'dje
  :set
  #'(lambda (var value)
      (progn (set-default var value)
             (set-face-attribute 'default nil :height value))))

(set-face-attribute 'default nil :font "Hack" :height dje-face-height)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(require 'saveplace)
;; saveplace remembers your location in a file when saving files
(setq save-place-file (expand-file-name "saveplace" dje-savefile-dir))
;; activate it for all buffers
(save-place-mode t)

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      ;; search entries
      '(search-ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (expand-file-name "savehist" dje-savefile-dir))
(savehist-mode t)

;; save recent files
(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" dje-savefile-dir)
      recentf-max-saved-items 500
      recentf-max-menu-items 15
      ;; disable recentf-cleanup on Emacs start, because it can cause
      ;; problems with remote files
      recentf-auto-cleanup 'never)
(recentf-mode t)

;; use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings)

;; CMD is Meta, ALT is Super
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks" dje-savefile-dir)
      bookmark-save-flag 1)

;; Setup packages
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(setq package-user-dir (expand-file-name "elpa" config-dir))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package for managing packages
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-solarized-dark t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config))

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "Hack Nerd Font Mono"))

;(use-package all-the-icons
;  :if (display-graphic-p))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package page-break-lines)

(use-package projectile
  :config
  (setq projectile-cache-file (expand-file-name "projectile.cache" dje-savefile-dir))
  (setq projectile-known-projects-file (expand-file-name "projectile-bookmarks.cache" dje-savefile-dir))
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode t))

(use-package dashboard
  :if (< (length command-line-args) 2)
  :custom
  (dashboard-startup-banner 'logo)
  :config
  (setq dashboard-set-init-info t)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))
  (dashboard-setup-startup-hook))

(use-package smartparens
  :init
  (setq sp-base-key-bindings 'paredit)
  (setq sp-autoskip-closing-pair 'always)
  (setq sp-hybrid-kill-entire-symbol nil)
  (sp-use-paredit-bindings)
  (show-smartparens-global-mode t))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy-rich
  :init
  (ivy-rich-mode t))

(use-package slime
  :init
  (cond ((file-exists-p "~/quicklisp/slime-helper.el")
         (load (expand-file-name "~/quicklisp/slime-helper.el")))
        ((file-exists-p "~/.quicklisp/slime-helper.el")
         (load (expand-file-name "~/quicklisp/slime-helper.el"))))
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-scratch slime-editing-commands slime-asdf)))

(use-package flycheck
  :custom
  (flycheck-keymap-prefix (kbd "C-c f"))
  :init
  (global-flycheck-mode)
  :config
  (when (and 'which-key-add-key-based-replacements)
    (which-key-add-key-based-replacements
      "C-c f" "flycheck")))

(use-package flycheck-inline
  :requires flycheck
  :init (global-flycheck-inline-mode))

(use-package company
;  :bind
;  ("<tab>" . company-indent-or-complete-common)
  :init (global-company-mode t))

(use-package magit
  :bind
  ("C-c g" . magit-file-dispatch))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(use-package go-mode
  :mode (("\\.go\\'" . go-mode)))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :config (lsp-enable-which-key-integration t)
  :hook ((go-mode) . lsp))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t))

;; Open files with .cl extension in lisp-mode
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

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
