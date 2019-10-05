(server-mode)
(load-theme 'doom-one-light t)
(global-auto-revert-mode t)
(global-visual-line-mode t) ;truncate  lines
(+global-word-wrap-mode t) ;truncate  lines

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


(def-package! super-save
  :init
  :config
  (super-save-mode +1))


;; (def-package! highlight-indent-guides
;; :config
;; (setq highlight-indent-guides-auto-enabled nil)
;; (setq highlight-indent-guides-method 'character)
;; (setq highlight-indent-guides-character ?\|)
;; ;; :custom-face
;; (set-face-background 'highlight-indent-guides-even-face "#040404")
;; (set-face-foreground 'highlight-indent-guides-odd-face "#dee6ed")
;; (set-face-foreground 'highlight-indent-guides-character-face "red")
;; )

(def-package! rotate-text
  :config
  (setq rotate-text-words '(("true" "false")
                            ("width" "height")
                            ("left" "right" "top" "bottom")
                            ("Background" "Foreground")
                            ("background" "foreground")
                            ("beginning" "end")
                            ("even" "odd"))))

(def-package! org-fancy-priorities
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")))


(map! :desc "format whole buffer wenn nothing selected"
      :leader
      :n "ri" #'weiss-indent)

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
  (map! :desc "switch-and-bookmarks-suchen"
        :leader
        :n "rr" #'switch-and-bookmarks-suchen())
  (map! :desc "pinyin-search"
        :leader
        :n "rs" #'pinyin-search)
  (map! :desc "create-table"
        :leader
        :nv "rjt" #'org-table-create-or-convert-from-region)
  ;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ switch and Bookmarks suchen
  (setq org-agenda-custom-commands '(("b" occur-tree ":Bookmarks:")))
  (fset 'switch-and-bookmarks-suchen
        (kbd "C-M-p E SPC o a a b"))
  (defun switch-to-Einsammlung()
    (interactive)
    (switch-to-buffer "Einsammlung.org"))
  (map! :desc "switch-to-Einsammlung" :ne "C-M-p E" #'switch-to-Einsammlung())
  ;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
  ;; ---------------------------------------------------------------------------
  (defun weiss-org-option ()
    (interactive)
    (setq
     display-line-numbers 'nil))




  (add-hook 'org-mode-hook 'weiss-org-option)

  (map! :desc "go to end of line and eval"
        :leader
        :ne "a" #'weiss-eval-last-sexp())
  (defun weiss-eval-last-sexp()
    (interactive)
    (end-of-line)
    (eval-last-sexp())))

;; after org done

(defun weiss-indent()
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))))



(setq display-line-numbers-type 'relative)
