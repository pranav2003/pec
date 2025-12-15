;;;  -*- lexical-binding: t; -*-
;;; c-family-setup.el -- Configurations for C-like languages
;;;

(add-hook 'csharp-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))

(when-mac (setenv "CPLUS_INCLUDE_PATH" "/opt/homebrew/include"))
