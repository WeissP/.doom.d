;;; ~/.doom.d/+keybindings.el -*- lexical-binding: t; -*-

;;Key Configuration for Doom as Vanilla Emacs
;; (setq evil-default-state 'emacs)

;; (def-package! xah-fly-keys
;;   :config
;;   (xah-fly-keys-set-layout "qwerty")
;;   (xah-fly-keys 1)
;;   )

(map!
 :leader
 :ne "rd" #'weiss-custom-daily-agenda
 :ne "a"
 #'weiss-eval-last-sexp()
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
 (:after org-noter
 :mode pdf-view-mode
 :map pdf-view-mode-map
 :nv "SPC dd" 'weiss-direct-insert-note
 :nv "SPC dh" 'pdf-annot-add-highlight-markup-annotation
 :nv "SPC ds" 'weiss-direct-annot-and-insert-note
 :nv "SPC dc" 'org-noter-sync-current-note
 :nv "SPC do" 'weiss-creat-org-pdf-link
 ))


(map!
 (:after org
   :leader
   :nv "ro" #'org-noter
   :nv "rb" #'org-babel-tangle ;; write code block in files
   :n "M-j" #'org-metadown
   :n "M-k" #'org-metaup
   :n "rs" #'org-sort-entries
   :n "rt" #'org-tags-sparse-tree
   :n "ra" #'weiss-org-archive()
   :n "rp" #'pinyin-search
   :nv "rjt" #'org-table-create-or-convert-from-region
   :nv "dc" #'org-noter-sync-current-note
   :nv "da" #'weiss-org-screenshot
   :nv "tt" #'weiss-org-latex-preview-all
   ))


