;;;  -*- lexical-binding: t; -*-
;;; pdf-setup.el -- Setup for viewing PDF documents
;;;

(use-package doc-view
  :config
  (setq doc-view-resolution 180
        doc-view-continuous t
        doc-view-cache-directory
        (expand-file-name "doc-view/" user-emacs-directory)))
