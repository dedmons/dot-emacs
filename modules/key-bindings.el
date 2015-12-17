(require 'bind-key)

;; Company key bindings
(bind-key "C-c e" 'company-complete)
(bind-key "C-c y" 'company-yasnippet)

;; Helm key bindings
(bind-key "M-x" 'helm-M-x)
(bind-key "C-x b" 'helm-mini)
(bind-key "C-x C-f" 'helm-find-files)
(bind-key "C-c h g" 'helm-google-suggest)
(bind-key "C-c h" 'helm-command-prefix)

(global-unset-key (kbd "C-x c")) ;; Unset default helm prefix

(bind-keys :map helm-map
           ("<tab>" . helm-execute-persistent-action) ; rebind tab to run persistant action
           ("C-i" . helm-execute-persistent-action) ; make tab work in terminal
           ("C-z" . helm-select-action)) ; list actions with C-z

;; Obj-C key bindings
(add-hook 'objc-mode-hook #'(lambda ()
                              (bind-key "C-c t" 'dje/objc-jump-between-header-source objc-mode-map)
                              (bind-key "C-c h h" 'dje/helm-objc-headlines objc-mode-map)))

;; Set C-x C-b to show buffer menu in current window instead of in a split
(bind-key "C-x C-b" 'buffer-menu)

;; Magit
(bind-key "C-M-g" 'magit-status)

;; Neotree
(bind-key "C-M-t" 'neotree-toggle)
