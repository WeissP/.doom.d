;;; ~/.doom.d/+edit.el -*- lexical-binding: t; -*-

(def-package! shiftless
  :config
  (shiftless-programming)
  (setq shiftless-delay 0.45)
  (setq shiftless-interval 0.06)
  (advice-add 'sp--post-self-insert-hook-handler :around #'shiftless--prevent-advice)
  (shiftless-mode 1)
)

(global-subword-mode 1)


;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ toggle up/lower-case
(defun weiss-toggle-up-lower-case-of-single-character(charPoint)
  (interactive)
  (let ((char (buffer-substring-no-properties charPoint (+ charPoint 1)))
        (upcaseChar (upcase (buffer-substring-no-properties charPoint (+ charPoint 1)))))
    (if (equal char upcaseChar)
        (evil-downcase charPoint (+ charPoint 1))
      (evil-upcase charPoint (+ charPoint 1))
      )
    ;; (goto-char charPoint)
    )
  )

(defun weiss-toggle-up-lower-case()
  (interactive)
  (if (use-region-p)
      (let ((count 0))
        (while (< count (- (region-end) (region-beginning)))
          (weiss-toggle-up-lower-case-of-single-character(+ (region-beginning) count))
          (setq count (+ count 1))
          )
        )
    (weiss-toggle-up-lower-case-of-single-character (point))
    )
  )
;;↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;;----------------------------------------------------


(def-package! rotate-text
  :config
  (setq rotate-text-words '(("true" "false")
                            ("width" "height")
                            ("left" "right" "top" "bottom")
                            ("Background" "Foreground")
                            ("background" "foreground")
                            ("beginning" "end")
                            ("forward" "backward")
                            ("expand" "contract")
                            ("enable" "disable")
                            ("even" "odd"))))


(defun weiss-indent()
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))))



(defun weiss-insert-backslash()
  (interactive)
  (insert "\\")
  )


;;Exit insert mode by pressing j and then j quickly
;; (setq key-chord-two-keys-delay 0.3)
;; (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;; (key-chord-mode 1)
