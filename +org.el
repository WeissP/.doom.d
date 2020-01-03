;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-


(def-package! org-fancy-priorities
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")))

(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))
;; (add-hook 'org-mode-hook #'auto-fill-mode)
;; (add-hook 'org-mode-hook 'toggle-truncate-lines)



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
                      :height 0.9
                      :foreground "#606060"
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
  (sp-pair "$" "$") ;; for latex
  (setq
   ;; yas-indent-line 'nil
   ;; yas-also-auto-indent-first-line 'nil
   org-agenda-skip-scheduled-if-done t
   org-log-done 'time
   org-fast-tag-selection-single-key t
   org-agenda-include-diary t
   cdlatex-math-symbol-alist '(
                               ( ?v  ("\\vee"   "\\vDash"         ))
                               ( ?+  ("\\cup"   "\\equiv"         ))
                               ( ?{  ("\\subset" "\\subseteq"        ))
                               ( ?}  ("\\supset"  "\\supseteq"       ))
                               )
   org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                        (66 :foreground "#da8548")
                        (67 :foreground "#0098dd"))

   ;; org-tag-faces '(
   ;;                 ("Frage" . (:foreground "red"))
   ;;                 )
   org-agenda-custom-commands
   '(
     ("c" "Custom agenda"
      ((agenda ""))
      (
       (org-agenda-tag-filter-preset '("+dailyagenda"))
       (org-agenda-hide-tags-regexp (concat org-agenda-hide-tags-regexp "\\|dailyagenda"))
       (org-agenda-span 20)
       ))
     ("b" occur-tree "Bookmarks")
     )
   org-directory "~/Documents/Org/"
   ;; org-agenda-files "~/Dokumente/Org/*.org"
   org-image-actual-width 300
   org-agenda-files (list org-directory)
   ;; org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
   org-todo-keywords '((sequence "INPROGRESS(i)" "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c@)"))
   org-cycle-max-level 15
   org-fontify-done-headline t
   org-agenda-compact-blocks t
   org-image-actual-width '(600)
   org-capture-templates   '(("o" "org-noter" entry (file "~/Documents/Org/Vorlesungen.org")
                              "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
                             )
   org-bullets-bullet-list '("◉" "◆" "●" "◇" "○" "→" "·" )
;;; “♰” “☥” “✞” “✟” “✝” “†” “✠” “✚” “✜” “✛” “✢” “✣” “✤” “✥” “♱” "✙”  "◉"  "○" "✸" "✿" ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶

   )

  (defun weiss-org-archive()
    (interactive)
    (setq current-prefix-arg '(4))
    (call-interactively 'org-archive-subtree)
    )

  (defun weiss-org-latex-preview-all()
    (interactive)
    (setq current-prefix-arg '(16))
    (call-interactively 'org-latex-preview)
    )

  (defun weiss-org-option ()
    (interactive)
    (iimage-mode)
    (emojify-mode)
    (make-local-variable 'shiftless-upper-rules)
    (shiftless-Umlaut)
    (setq
     display-line-numbers 'nil)
    ;; (let ((current-prefix-arg '(16)))
    ;;   (call-interactively 'org-latex-preview)
    ;;   )
    )


  (add-hook 'org-mode-hook 'weiss-org-option)


  (defun weiss-org-screenshot ()
    "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
    (interactive)
    ;; (setq filename
    ;;       (concat
    ;;        (make-temp-name
    ;;         (concat (buffer-file-name)
    ;;                 "_"
    ;;                 (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
    (setq pathFileName
          (concat "./Bilder/"
                  (concat
                   (make-temp-name
                    (concat (buffer-name)
                            "_"
                            (format-time-string "%Y%m%d_%H%M%S_")) ) ".png")
                  )
          )
    (call-process "import" nil nil nil pathFileName)
    (insert (concat "[[" pathFileName "]]"))
    (org-display-inline-images))

  ;;https://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it

  )

(defun weiss-custom-daily-agenda()
  (interactive)
  (org-agenda nil "c")
  )
;; (getenv "PATH")


(setq org-capture-templates
      '(("o" "org-noter" entry (file "~/Documents/Org/Vorlesungen.org")
         "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
        ))


;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ switch and Bookmarks suchen
(defun weiss-switch-and-Bookmarks-search()
  (interactive)
  (find-file "~/Documents/Org/Einsammlung.org")
  (org-agenda nil "b")
  )
(map! :desc "switch and Bookmarks search"
      :leader
      :nv "rr" #'weiss-switch-and-Bookmarks-search)
;;  ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; -----------------------------------------------------------
