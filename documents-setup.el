;;;  -*- lexical-binding: t; -*-
;;; documents-setup.el -- Setup for viewing documents of various types
;;;

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

(use-package csv-mode
  :defer t)

(use-package markdown-mode
  :defer t)

(use-package pdf-tools
  :hook (doc-view-mode . pdf-tools-install))

