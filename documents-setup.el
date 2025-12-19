;;;  -*- lexical-binding: t; -*-
;;; documents-setup.el -- Setup for viewing documents of various types
;;;

(use-package pdf-tools
  :config
  (pdf-tools-install))

(use-package pdf-tools
  :hook (doc-view-mode . pdf-tools-install))

(use-package csv-mode
  :defer t)
