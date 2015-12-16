(require 'helm-utils)

(add-to-list 'auto-mode-alist '("\\.h$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.mm$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.pch$" . objc-mode))

(defun dje/helm-objc-headlines ()
  "Display headlines for the current Objective-C file."
  (interactive)
  (setq helm-current-buffer (current-buffer)) ;; Fixes bug where the current buffer sometimes isn't used
  (jit-lock-fontify-now) ;; https://groups.google.com/forum/#!topic/emacs-helm/YwqsyRRHjY4
  (helm :sources (helm-build-in-buffer-source "Objective-C Headlines"
                   :data (with-helm-current-buffer
                           (goto-char (point-min))
                           (cl-loop while (re-search-forward "^[-+@]\\|^#pragma mark" nil t)
                                    for line = (buffer-substring (point-at-bol) (point-at-eol))
                                    for pos = (line-number-at-pos)
                                    collect (propertize line 'helm-realvalue pos)))
                   :get-line 'buffer-substring
                   :candidate-number-limit 500
                   :follow 1
                   :action (lambda (c) (helm-goto-line c)))
        :buffer "helm-objc-headlines"))

;; --- Obj-C switch between header and source ---

(defun dje/objc-in-header-file ()
  (let* ((filename (buffer-file-name))
         (extension (car (last (split-string filename "\\.")))))
    (string= "h" extension)))

(defun dj/objc-jump-to-extension (extension)
  (let* ((filename (buffer-file-name))
         (file-components (append (butlast (split-string filename
                                                         "\\."))
                                  (list extension))))
    (find-file (mapconcat 'identity file-components "."))))

;;; Assumes that Header and Source file are in same directory
(defun dje/objc-jump-between-header-source ()
  (interactive)
  (if (dje/objc-in-header-file)
      (dje/objc-jump-to-extension "m")
    (dje/objc-jump-to-extension "h")))

