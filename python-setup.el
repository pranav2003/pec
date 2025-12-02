;;;  -*- lexical-binding: t; -*-
;;; python-setup.el -- Configurations for Python3
;;;

(use-package lsp-pyright
  :defer t
  :custom (lsp-pyright-langserver-command "pyright"))

(use-package pyvenv
  :defer t)

(use-package py-vterm-interaction
  :config
  (setq-default py-vterm-interaction-repl-program "python3"))

(add-hook 'python-mode-hook
	  (lambda ()
	    (lsp-deferred)
	    (py-vterm-interaction-mode)))
