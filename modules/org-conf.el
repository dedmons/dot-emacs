;; Org Mode for .txt, .org, and .org_archive
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(require 'org)

(setq org-directory "~/Documents/org")
(setq org-default-notes-file "~/Documents/org/inbox.org")

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

(setq org-capture-templates
      (quote (("t" "todo" entry (file "inbox.org")
               "* TODO %?\n%U\n")
              ("n" "note" entry (file "inbox.org")
               "* %? :NOTE:\n%U\n")
              ))
      )
