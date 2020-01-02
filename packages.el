;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! org-fancy-priorities)
(package! pinyin-search)
(package! org-protocol :disable t)
(package! super-save)
(package! aggressive-indent)
(package! rainbow-mode)
(package! expand-region)
(package! emojify)
(package! org-pdftools :disable t)
(package! org-noter)
(package! telega :disable t)
(package! visual-fill-column :disable t)
(package! cdlatex)
(package! auctex)
(package! german-holidays)
(package! org-mind-map :disable t)
(package! fsharp-mode)
(package! key-chord :disable t)
(package! delete-block :disable t)
(package! vterm)
(package! powerline :disable t)
(package! shiftless.el :recipe
  (:host github
   :repo "WeissP/shiftless.el"
   :branch "master"
))
(package! jsonrpc :disable t)
(package! jieba :recipe (:host github :repo "cireu/jieba.el") :disable t)
