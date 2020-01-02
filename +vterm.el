;;; ~/.doom.d/+vterm.el -*- lexical-binding: t; -*-

(def-package! vterm
  :config
  (setq vterm-shell "zsh")
  (add-hook 'vterm-set-title-functions 'vterm--rename-buffer-as-title))

(defun vterm--rename-buffer-as-title (title)
  (rename-buffer (format "vterm @ %s" title) t))
