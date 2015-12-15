
(use-package ledger-mode
  :ensure t
  :config
  ;; Fix ledger path in cocoa ledger
  (set 'ledger-path (shell-command-to-string "which ledger"))
  (set 'ledger-binary-path
       (if (string= "" 'ledger-path)
           (car (last
                 (split-string
                  (substring 'ledger-path 0 -1)
                  "\n")
                 ))
         'ledger-path))

  (set 'ledger-post-amount-alignment-column 60)

  (eval-after-load "ledger-mode"
    '(define-key ledger-mode-map (kbd "M-p") (lambda ()
                                               (interactive)
                                               (ledger-navigate-prev-xact)
                                               (beginning-of-line))))
  )
