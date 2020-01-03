(server-mode)
(global-auto-revert-mode t)
;; (add-hook 'after-init-hook #'global-emojify-mode) ;; show emoji as picture

;; (add-to-list 'load-path "/home/weiss/elisp/rainbow-mode/")
;; (load "rainbow-mode")

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
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ----------------------------------------------------------


(use-package! company-tabnine
  :when (featurep! :completion company)
  :config
  ;; (add-to-list 'company-backends #'company-tabnine)
  ;; (set-company-backend! 'text-mode
  ;;   'company-tabnine 'company-dabbrev 'company-yasnippet 'company-ispell)
  ;; (set-company-backend! 'conf-mode
  ;;   'company-tabnine 'company-capf 'company-dabbrev-code 'company-yasnippet)
  (set-company-backend! 'prog-mode
    'company-tabnine 'company-capf 'company-yasnippet)
  (setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))
  ;; (setq +lsp-company-backend '(company-tabnine :with company-lsp :separate))
  ;;慢一点，不要太快出来提示框，会影响思路的
  (setq company-idle-delay 0.3))


;; Recent files
;; recentf-cleanup will update recentf-list
(use-package recentf
  :preface
  (defun snug/recentf-save-list-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-save-list))
        (recentf-save-list)))
    (message ""))
  (defun snug/recentf-cleanup-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-cleanup))
        (recentf-cleanup)))
    (message ""))
  :config
  (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)

  (setq
   ;; recentf-max-menu-items 150
   ;; recentf-max-saved-items 150
   recentf-auto-cleanup '60
   ;; Recentf blacklist
   recentf-exclude '(
                     ".*autosave$"
                     ".*archive$"
                     ".*.jpg$"
                     ".*.png$"
                     ".*.gif$"
                     ".cache"
                     "cache"
                     ))
  )

(def-package! deft
  :config
  (setq deft-directory "/home/weiss/Documents/Org/")
  (setq deft-use-filename-as-title t)
  )

