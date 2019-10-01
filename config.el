;;; .doom.d/config.el -*- lexical-binding: t; -*-
(server-mode)
(load-theme 'doom-one-light t)
(setq inhibit-splash-screen t)
(global-auto-revert-mode t)

(setq
 doom-font (font-spec :family "SF Mono" :size 14)
 doom-big-font (font-spec :family "SF Mono" :size 20)
 doom-variable-pitch-font (font-spec :family "Avenir Next" :size 17)
 ;----------------------------------------------------- org-mode
 yas-indent-line 'nil
 yas-also-auto-indent-first-line 'nil
 org-agenda-skip-scheduled-if-done t
 org-log-done 'time
 ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
)

(add-hook 'org-mode-hook #'auto-fill-mode)
(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))


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

  ;; (setq line-spacing 1.5)

  (map! :map org-mode-map
      :n "M-j" #'org-metadown
      :n "M-k" #'org-metaup
      )
  (setq
   org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                        (66 :foreground "#da8548")
                        (67 :foreground "#0098dd")
                        )
   org-directory "~/Dokumente/Org/"
   ;; org-agenda-files "~/Dokumente/Org/*.org"
   org-agenda-files (list org-directory)
   ;; org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
   org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c@)"))
   )

  (use-package! org-fancy-priorities
    :hook (org-mode . org-fancy-priorities-mode)
    :config
    (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄"))
    )

  (setq org-fontify-done-headline t)
  (setq org-agenda-compact-blocks t)
  (map! :desc "Create Sparse Tree for Tags" :ne "SPC r t" #'org-tags-sparse-tree)
  (map! :desc "switch-and-bookmarks-suchen" :ne "SPC r r" #'switch-and-bookmarks-suchen())
  (map! :desc "pinyin-search" :ne "SPC r s" #'pinyin-search)
  ;----------------------------------------------------- switch and Bookmarks suchen
 (setq org-agenda-custom-commands '(("b" occur-tree ":Bookmarks:")))
  (fset 'switch-and-bookmarks-suchen
        (kbd "C-M-p E SPC o a a b"))
  (defun switch-to-Einsammlung()
    (interactive)
    (switch-to-buffer "Einsammlung.org"))
  (map! :desc "switch-to-Einsammlung" :ne "C-M-p E" #'switch-to-Einsammlung())
  ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ;----------------------------------------------------- turn off line numbers in Org-mode
  (defun nolinum ()
     (interactive)
     (setq display-line-numbers 'nil)
     )
   (add-hook 'org-mode-hook 'nolinum)
   )
  ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

(find-file "/home/weiss/Dokumente/Org/Kenntnisse.org")
(find-file "/home/weiss/Dokumente/Org/todo.org")
(find-file "/home/weiss/Dokumente/Org/Einsammlung.org")
(find-file "/home/weiss/Dokumente/Org/Zusammenhang.org")

(setq display-line-numbers-type 'relative)
