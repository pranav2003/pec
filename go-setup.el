;;;  -*- lexical-binding: t; -*-
;;; go-setup.el -- Customizations for programming in Go
;;;

(use-package go-mode
  :defer t)

(add-hook 'go-mode-hook
	  (lambda ()
	    (setq tab-width 4)))
