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
