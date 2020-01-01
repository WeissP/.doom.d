(server-mode)
(load-theme 'doom-one-light t)
(add-to-list 'load-path "/home/weiss/elisp/shiftless.el")
(global-auto-revert-mode t)
(global-visual-line-mode t) ;truncate  lines
(+global-word-wrap-mode t) ;truncate  lines
;; (add-hook 'after-init-hook #'global-emojify-mode) ;; show emoji as picture

(load "shiftless")
(setq fancy-splash-image "/home/weiss/Documents/Org/Bilder/ue-light.png")
(rainbow-mode +1)
;; (require 'shiftless)
(shiftless-programming)
(setq shiftless-delay 0.45) ;; larger than 0.18
(setq shiftless-interval 0.06) ;; larger than 0.045
(shiftless-mode 1)

;; (powerline-default-theme)
(global-subword-mode 1)

;; (global-aggressive-indent-mode 1)
;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
(defun weiss-global-option()
  (interactive)
  (rainbow-turn-on)
  )
(add-hook 'find-file-hook 'weiss-global-option)
(def-package! super-save
  :init
  :config
  (super-save-mode +1))
(def-package! vterm
  :config
  (setq vterm-shell "zsh")
  (add-hook 'vterm-set-title-functions 'vterm--rename-buffer-as-title))

(defun vterm--rename-buffer-as-title (title)
  (rename-buffer (format "vterm @ %s" title) t))

(require 'tramp)
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

(defun my-highlighter (level responsive display)
  ;; (if (or (< level 2)(= 0 (mod level 2)))
  ;; (if (= 0 (mod level 2))
  (if (or (< level 1))
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
                            ("enable" "disable")
                            ("even" "odd"))))

(def-package! org-fancy-priorities
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")))

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

;; TAG global-settings
(setq
 ;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ face
 doom-font (font-spec :family "SF Mono" :size 15)
 doom-big-font (font-spec :family "SF Mono" :size 20)
 doom-variable-pitch-font (font-spec :family "Avenir Next" :size 17)
 ;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
 org-noter-insert-note-no-questions 't
 org-noter-auto-save-last-location 't
 auto-save-default 'nil
 company-idle-delay 0.1
 large-file-warning-threshold 100000000
 +ivy-task-tags '(("TODO" . warning)
                  ("FIXME" . error)
                  ("TAG" . tag)
                  )
 )
(map!
 :leader
 :ne "rd" #'weiss-custom-daily-agenda
 :ne "a" #'weiss-eval-last-sexp()
 :nv "<RET>" #'+default/project-tasks ;; tag search
 :n "ri" #'weiss-indent ;;format whole buffer wenn nothing selected
 :n "el" #'sp-forward-slurp-sexp ;; Fn18 include new var (right side)
 :n "eh" #'sp-forward-barf-sexp ;; exclude new var (right side)
 :n "eH" #'sp-backward-slurp-sexp ;; include new var(left side)
 :n "eL" #'sp-backward-barf-sexp ;; exclude new var(left side)
 :n "et" #'sp-transpose-sexp ;; trade places
 :n "ek" #'sp-kill-sexp ;; delete expression
 :n "eK" #'sp-kill-hybrid-sexp ;; delete backward all expression
 :n "ov" #'vterm-other-window
 )

(map!
 :n "gu" #'weiss-toggle-up-lower-case
 :nei "S-<delete>" #'weiss-insert-backslash
 :nei "M-n" #'sp-beginning-of-sexp ;; move point to the start of the string
 :nei "M-m" #'sp-end-of-sexp ;Fn9
 :n "C-s" #'weiss-counsel-grep-or-swiper ;; "swip search" original command: (isearch-forward &optional REGEXP-P NO-RECURSIVE-EDIT)
 :nvi "M-[" #'er/expand-region ;; expand region
 :nvi "M-]" #'er/contract-region
 )

(map!
 :after org-noter
 :mode pdf-view-mode
 :map pdf-view-mode-map
 :nv "SPC dd" 'weiss-direct-insert-note
 :nv "SPC dh" 'pdf-annot-add-highlight-markup-annotation
 :nv "SPC ds" 'weiss-direct-annot-and-insert-note
 :nv "SPC dc" 'org-noter-sync-current-note
 :nv "SPC do" 'weiss-creat-org-pdf-link
 )

(defun weiss-direct-annot-and-insert-note()
  (interactive)
  (let ((pdfBuffer (buffer-name))
        (markedText (org-noter--get-precise-info))
        (list (pdf-view-active-region))
        )
    (pdf-annot-add-markup-annotation list 'highlight)
    (org-noter-insert-precise-note)
    (org-up-element)
    (org-set-tags ":Frage:")
    (evil-exit-visual-state nil pdfBuffer) ;; conflict between evil and pdf text selection
    )
  )
(defun weiss-direct-insert-note()
  "direct annot and insert note with selected text"
  (interactive)
  (let ((pdfBuffer (buffer-name))
        (markedText (org-noter--get-precise-info))
        )
    (org-noter-insert-precise-note)
    (evil-exit-visual-state nil pdfBuffer) ;; conflict between evil and pdf text selection
    )
  )


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
  (sp-pair "$" "$")
  ;; TAG org-settings
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

  (map!
   :leader
   :nv "ro" #'org-noter
   :nv "rb" #'org-babel-tangle ;; write code block in files
   :n "M-j" #'org-metadown
   :n "M-k" #'org-metaup
   :n "rs" #'org-sort-entries
   :n "rt" #'org-tags-sparse-tree
   :n "rp" #'pinyin-search
   :nv "rjt" #'org-table-create-or-convert-from-region
   :nv "dc" #'org-noter-sync-current-note
   :nv "da" #'weiss-org-screenshot
   :nv "tt" #'weiss-org-latex-preview-all
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

  )
;; after org done

;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ quick eval
(defun weiss-eval-last-sexp()
  (interactive)
  (end-of-line)
  (eval-last-sexp()))
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ---------------------------------------------------------------------------

(defun weiss-pdf-option()
  (interactive)
  ;; (sleep-for 5)
  (pdf-annot-minor-mode)
  ;; (org-noter)
  )

;; (add-hook 'pdfview-mode-hook 'pdf-annot-minor-mode)
(add-hook 'pdf-view-mode-hook 'weiss-pdf-option)

(defun weiss-indent()
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))))



(setq display-line-numbers-type 'relative)

;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ switch and Bookmarks suchen
(defun weiss-switch-and-Bookmarks-search()
  (interactive)
  (find-file "~/Documents/Org/Einsammlung.org")
  (org-agenda nil "b")
  )
(map! :desc "switch and Bookmarks search"
      :leader
      :nv "rr" #'weiss-switch-and-Bookmarks-search)
;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; ---------------------------------------------------------------------------

(defun weiss-custom-daily-agenda()
  (interactive)
  (org-agenda nil "c")
  )


;; (getenv "PATH")

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

;;https://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-ithttps://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-ithttps://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it


(setq org-capture-templates
      '(("o" "org-noter" entry (file "~/Documents/Org/Vorlesungen.org")
         "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
        ))

(defun weiss-insert-backslash()
  (interactive)
  (insert "\\")
  )

(font-lock-add-keywords 'org-mode
                        '(("^.*:Frage:.*$" . font-lock-keyword-face)))

;;Exit insert mode by pressing j and then j quickly
;; (setq key-chord-two-keys-delay 0.3)
;; (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;; (key-chord-mode 1)

(image-type-available-p 'imagemagick)
