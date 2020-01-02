;;; ~/.doom.d/+pdf.el -*- lexical-binding: t; -*-


(setq
 org-noter-insert-note-no-questions 't
 org-noter-auto-save-last-location 't
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


(defun weiss-pdf-option()
  (interactive)
  ;; (sleep-for 5)
  (pdf-annot-minor-mode)
  ;; (org-noter)
  )


(add-hook 'pdf-view-mode-hook 'weiss-pdf-option)
