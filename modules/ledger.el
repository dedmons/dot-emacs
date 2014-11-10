;; Fix ledger path in cocoa ledger
(set 'ledger-binary-path
  (car (last
    (split-string
      (substring
        (shell-command-to-string "which ledger")
      0 -1)
    "\n")
   )))

(set 'ledger-post-amount-alignment-column 60)

(eval-after-load "ledger-mode"
  '(define-key ledger-mode-map (kbd "M-p") (lambda ()
					     (interactive)
					     (ledger-navigate-prev-xact)
					     (beginning-of-line))))
