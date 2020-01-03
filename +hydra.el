;;; ~/.doom.d/+hydra.el -*- lexical-binding: t; -*-


(defhydra resize-window (global-map "M-w")
  "resize window"
  ("k" evil-window-increase-height "height+")
  ("j" evil-window-decrease-height "height-")
  ("h" evil-window-decrease-width "width-")
  ("l" evil-window-increase-width "width+")
  ("q" nil "quit")
  )

(defhydra hydra-error (global-map "M-g")
  "goto-error"
  ("h" first-error "first")
  ("j" next-error "next")
  ("k" previous-error "prev")
  ("v" recenter-top-bottom "recenter")
  ("q" nil "quit"))
