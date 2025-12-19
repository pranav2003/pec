;;;  -*- lexical-binding: t; -*-
;;; csharp-setup.el -- Configurations for C#
;;;

(add-hook 'csharp-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (eglot-ensure)))
