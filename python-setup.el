;;;  -*- lexical-binding: t; -*-
;;; python-setup.el -- Configurations for Python3
;;;

(use-package lsp-pyright
  :defer t
  :custom (lsp-pyright-langserver-command "pyright"))

(use-package pyvenv
  :defer t)
