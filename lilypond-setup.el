;;;  -*- lexical-binding: t; -*-
;;; lilypond-setup.el -- Configure LilyPond mode installed with homebrew
;;;

(when-mac (load-file "/opt/homebrew/share/emacs/site-lisp/lilypond/lilypond-init.el"))
(when-linux (load-file "/usr/share/emacs/site-lisp/lilypond-init.el"))

(when-mac (setq load-path
		(append '("/opt/homebrew/share/emacs/site-lisp/lilypond")
			load-path)))

(add-hook 'LilyPond-mode-hook
	  (lambda ()
	    (flycheck-mode 1)
	    (display-line-numbers-mode 1)))
