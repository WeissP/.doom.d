(server-mode)
(global-auto-revert-mode t)
;; (add-hook 'after-init-hook #'global-emojify-mode) ;; show emoji as picture

;; (add-to-list 'load-path "/home/weiss/elisp/shiftless.el")
;; (load "shiftless")

(load! "+edit")
(load! "+vterm")
(load! "+ui")
(load! "+org")
(load! "+pdf")
(load! "+keybindings")



(defun weiss-global-option()
  (interactive)
  (rainbow-turn-on)
  (highlight-indent-guides-mode)
  )
(add-hook 'find-file-hook 'weiss-global-option)

(def-package! super-save
  :init
  :config
  (super-save-mode +1)
  (add-to-list 'super-save-triggers 'find-file)
  )

(def-package! german-holidays
  :config
  (setq calendar-holidays holiday-german-RP-holidays)
  )

(defun weiss-counsel-grep-or-swiper()
  (interactive)
  (if (use-region-p)
      (let ((regionString (buffer-substring-no-properties (region-beginning) (region-end))))
        (evil-exit-visual-state)
        (counsel-grep-or-swiper regionString)
        )
    (counsel-grep-or-swiper)
    )
  )

(setq
 auto-save-default 'nil
 company-idle-delay 0.1
 large-file-warning-threshold 100000000
 +ivy-task-tags '(("TODO" . warning)
                  ("FIXME" . error)
                  ("TAG" . tag)
                  )
 )


;; (image-type-available-p 'imagemagick)

;; lsp blacklist
;; (setf (lsp-session-folders-blacklist (lsp-session)) nil)
;; (lsp--persist-session (lsp-session))


;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ quick eval
(defun weiss-eval-last-sexp()
  (interactive)
  (end-of-line)
  (eval-last-sexp()))
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ---------------------------------------------------------------------------


