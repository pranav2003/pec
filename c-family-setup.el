;;;  -*- lexical-binding: t; -*-
;;; c-family-setup.el -- Configurations for C-like languages
;;;

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "stroustrup")
	    (lsp-deferred)
	    (flycheck-mode)))

(when-mac (setenv "CPLUS_INCLUDE_PATH" "/opt/homebrew/include"))
