;;;  -*- lexical-binding: t; -*-
;;; lsp-setup.el -- Setup for Language Server Protocol integration
;;;

;; Map major mode to lsp server program
(with-eval-after-load 'eglot
  (dolist (el '((qml-mode . ("qmlls"))))
    (add-to-list 'eglot-server-programs el)))
