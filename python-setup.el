;;;  -*- lexical-binding: t; -*-
;;; python-setup.el -- Configurations for Python3
;;;

(use-package lsp-pyright
  :defer t
  :custom (lsp-pyright-langserver-command "pyright"))

(use-package pyvenv
  :defer t)

(when-mac
 (add-hook 'python-mode-hook
	   (=> (setq python-shell-exec-path '("/usr/local/bin")))))
