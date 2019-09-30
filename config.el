;;; .doom.d/config.el -*- lexical-binding: t; -*-
(server-mode)
(load-theme 'doom-one-light t)
(setq inhibit-splash-screen t)
;; (custom-set-faces
;;  '(bold ((t (:foreground "#CD5C5C" :slant normal :weight bold :width normal :foundry "outline" :family "Source code pro"))))
;;  '(bold-italic ((t (:inherit (bold italic) :foreground "dim gray" :slant italic :weight bold :height 135 :width normal :foundry "outline" :family "Noto Sans Mono CJK SC"))))
;;  '(italic ((t (:foreground "slate gray" :slant italic :weight normal :height 140 :width expanded :foundry "outline" :family "MindBlue Bold Italic"))))
;;  '(org-level-1 ((t ( :height 1.5))))
;;  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
;;  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
;;  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
;;  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
;;  '(org-headline-done ((t (:height 0.8 :Strike-through t))))
;; )
(setq
 doom-font (font-spec :family "SF Mono" :size 20)
 doom-big-font (font-spec :family "SF Mono" :size 36)
 doom-variable-pitch-font (font-spec :family "Avenir Next" :size 18)
)


(global-auto-revert-mode t)
(add-hook 'org-mode-hook #'auto-fill-mode)
;; (add-hook 'org-mode-hook (lambda () (linum-mode 0)))
(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))


(after! org
  (set-face-attribute 'org-headline-done nil
                      :height 0.8
                      :strike-through t
                      :weight 'normal)
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

;; (find-file "/home/weiss/Dokumente/Org/Kenntnisse.org")
(find-file "/home/weiss/Dokumente/Org/todo.org")
(find-file "/home/weiss/Dokumente/Org/Einsammlung.org")
(find-file "/home/weiss/Dokumente/Org/Zusammenhang.org")

(setq display-line-numbers-type 'relative)
