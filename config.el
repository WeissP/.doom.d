(server-mode)
(load-theme 'doom-one-light t)
(global-auto-revert-mode t)
(global-visual-line-mode t) ;truncate  lines
(+global-word-wrap-mode t) ;truncate  lines

(add-hook 'after-init-hook #'global-emojify-mode) ;; show emoji as picture

(rainbow-mode +1)
(global-aggressive-indent-mode 1)
;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

(setq
 ;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ face
 doom-font (font-spec :family "SF Mono" :size 15)
 doom-big-font (font-spec :family "SF Mono" :size 20)
 doom-variable-pitch-font (font-spec :family "Avenir Next" :size 17)
 ;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
 auto-save-default 'nil
 ;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ org-mode
 yas-indent-line 'nil
 yas-also-auto-indent-first-line 'nil
 org-agenda-skip-scheduled-if-done t
 org-log-done 'time)
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
(defun weiss-global-option()
  (interactive)
  (rainbow-turn-on)
  )
(add-hook 'find-file-hook 'weiss-global-option)

(def-package! super-save
  :init
  :config
  (super-save-mode +1))


;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ toggle up/lower-case
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
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ---------------------------------------------------------------------------

;; (def-package! rainbow-mode
;;   :init
;;   :config
;;   )
;; (def-package! highlight-indent-guides
;; :config
;; (setq highlight-indent-guides-auto-enabled nil)
;; (setq highlight-indent-guides-method 'character)
;; (setq highlight-indent-guides-character ?\|)
;; ;; :custom-face
;; (set-face-background 'highlight-indent-guides-even-face "")
;; (set-face-foreground 'highlight-indent-guides-odd-face "")
;; (set-face-foreground 'highlight-indent-guides-character-face "")
;; )
(defun my-highlighter (level responsive display)
  ;; (if (or (< level 2)(= 0 (mod level 2)))
  (if (= 0 (mod level 2))
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))


(def-package! highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\>)
  (setq highlight-indent-guides-highlighter-function 'my-highlighter))



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
                            ("even" "odd"))))





(def-package! org-fancy-priorities
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")))

(map! :desc "expand region"
      :nvi "M-[" #'er/expand-region)
(map! :desc "expand region"
      :nvi "M-]" #'er/contract-region)

(map! :desc "toggle-up-lower-case"
      ;; :leader
      :n "gu" #'weiss-toggle-up-lower-case)

(map! :desc "test"
      :leader
      :n "rn" #'test)

(map! :desc "format whole buffer wenn nothing selected"
      :leader
      :n "ri" #'weiss-indent)

(map! :desc "move point to the start of the string"
      :nei "M-n" #'sp-beginning-of-sexp)

;; Fn9
(map! :desc "move point to the end of the string"
      :nei "M-m" #'sp-end-of-sexp)

;; Fn18
(map! :desc "include new var (right side)"
      :leader
      :n "el" #'sp-forward-slurp-sexp)

(map! :desc "exclude new var (right side)"
      :leader
      :n "eh" #'sp-forward-barf-sexp)

(map! :desc "include new var(left side)"
      :leader
      :n "eH" #'sp-backward-slurp-sexp)

(map! :desc "exclude new var(left side)"
      :leader
      :n "eL" #'sp-backward-barf-sexp)

(map! :desc "trade places"
      :leader
      :n "et" #'sp-transpose-sexp)

(map! :desc "delete expression"
      :leader
      :n "ek" #'sp-kill-sexp)

(map! :desc "delete backward all expression"
      :leader
      :n "eK" #'sp-kill-hybrid-sexp)

(add-hook 'org-mode-hook #'auto-fill-mode)
(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))
(add-hook 'org-mode-hook 'toggle-truncate-lines)

(after! org
  (set-face-attribute 'bold nil
                      :weight 'bold
                      :underline 'nil
                      :foreground "#f5355e"
                      :background nil)
  (set-face-attribute 'italic nil
                      :weight 'normal
                      :underline 'nil
                      :slant 'italic
                      :height 0.8
                      :foreground "#c0c0c0"
                      :background nil)
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :underline 'nil
                      :foreground "#20B2AA"
                      :background nil)
  (set-face-attribute 'org-block-begin-line nil
                      :weight 'normal
                      :slant 'italic
                      :underline 'nil
                      :foreground "#c0c0c0"
                      :background nil)
  (set-face-attribute 'org-block nil
                      :background "#fafafa")
  (set-face-attribute 'org-headline-done nil
                      :strike-through t
                      :weight 'normal)
  (set-face-attribute 'org-level-1 nil
                      :height 1.2
                      :foreground "#ff5a19"
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      :height 1.1
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-7 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-8 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  ;; (setq line-spacing 1.5)

  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)

  (setq
   org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                        (66 :foreground "#da8548")
                        (67 :foreground "#0098dd"))

   org-directory "~/Dokumente/Org/"
   ;; org-agenda-files "~/Dokumente/Org/*.org"
   org-agenda-files (list org-directory)
   ;; org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
   org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c@)"))
   org-cycle-max-level 15
   org-fontify-done-headline t
   org-agenda-compact-blocks t)


  (map! :desc "Create Sparse Tree for Tags"
        :leader
        :n "rt" #'org-tags-sparse-tree)
  (map! :desc "pinyin-search"
        :leader
        :n "rs" #'pinyin-search)
  (map! :desc "create-table"
        :leader
        :nv "rjt" #'org-table-create-or-convert-from-region)
  (defun weiss-org-option ()
    (interactive)
    (iimage-mode)
    (setq
     display-line-numbers 'nil))


  (add-hook 'org-mode-hook 'weiss-org-option)

  )
;; after org done

;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ quick eval
(map! :desc "go to end of line and eval"
      :leader
      :ne "a" #'weiss-eval-last-sexp())
(defun weiss-eval-last-sexp()
  (interactive)
  (end-of-line)
  (eval-last-sexp()))
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ---------------------------------------------------------------------------


(defun weiss-indent()
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))))



(setq display-line-numbers-type 'relative)

;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ switch and Bookmarks suchen
(setq org-agenda-custom-commands
      '(
        ("b" occur-tree "Bookmarks")
        )
      )
(defun weiss-switch-and-Bookmarks-search()
  (interactive)
  (find-file "~/Dokumente/Org/Einsammlung.org")
  (org-agenda nil "b")
  )
(map! :desc "switch and Bookmarks search"
      :leader
      :nv "rr" #'weiss-switch-and-Bookmarks-search)
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ---------------------------------------------------------------------------
(setq org-image-actual-width 300)
