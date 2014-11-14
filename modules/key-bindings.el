;; Set C-x C-b to show buffer menu in current window instead of in a split
(global-set-key (kbd "C-x C-b") 'buffer-menu)

(when (package-installed-p 'neotree)
  (global-set-key (kbd "C-M-t") 'neotree-toggle)
  )

(when (package-installed-p 'magit)
  (global-set-key (kbd "C-M-g") 'magit-status)
  )
