; (use-package helm
;   :ensure t
;   :config
;   (require 'helm-config)
;   (require 'recentf)
;
;   (setq recentf-max-saved-items 50)
;
;   (when (executable-find "curl")
;     (setq helm-google-suggest-use-curl-p t))
;
;   (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;         helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;         helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;         helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;         helm-ff-file-name-history-use-recentf t
;         helm-M-x-fuzzy-match                  t
;         helm-buffers-fuzzy-matching           t
;         helm-recentt-fuzzy-matching           t) ;; optional fuzzy matching for helm-M-x
;
;   (helm-mode 1))
