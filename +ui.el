;;; ~/.doom.d/+appearance.el -*- lexical-binding: t; -*-


(load-theme 'doom-one-light t)
(global-visual-line-mode t) ;truncate  lines
(+global-word-wrap-mode t) ;truncate  lines
(rainbow-mode +1)

(setq
 doom-font (font-spec :family "SF Mono" :size 15)
 doom-big-font (font-spec :family "SF Mono" :size 20)
 doom-variable-pitch-font (font-spec :family "SF Mono" :size 17)

 display-line-numbers-type 'relative
 fancy-splash-image "/home/weiss/Documents/Org/Bilder/ue-light.png"
 )



;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ highlight-indent-guides

(defun my-highlighter (level responsive display)
  ;; (if (or (< level 2)(= 0 (mod level 2)))
  ;; (if (= 0 (mod level 2))
  (if (or (< level 1))
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))

(def-package! highlight-indent-guides
  :config
  ;; character style
  ;; (setq highlight-indent-guides-method 'character)
  ;; (setq highlight-indent-guides-character ?\>)
  ;; (setq highlight-indent-guides-highlighter-function 'my-highlighter)

  ;; column style
  (setq highlight-indent-guides-auto-enabled nil)
  (setq highlight-indent-guides-method 'column)
  ;; (setq highlight-indent-guides-auto-odd-face-perc #a9a9a9)
  (set-face-background 'highlight-indent-guides-odd-face "#f5f5f5")
  (set-face-background 'highlight-indent-guides-even-face "#FAFAFA")
  ;; (setq highlight-indent-guides-auto-even-face-perc 15)
  )

;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; --------------------------------------------------


(font-lock-add-keywords 'org-mode
                        '(("^.*:Frage:.*$" . font-lock-keyword-face)))
