;;;  -*- lexical-binding: t; -*-
;;; org-setup.el -- Configurations for org-mode
;;;

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(add-hook 'org-mode-hook
	  (lambda ()
	    (flyspell-mode 0)
	    (org-indent-mode 1)
	    (abbrev-mode 1)
	    (setq captain-predicate
		  (lambda () (not (org-in-src-block-p)))
		  org-image-max-width 50)
	    (local-set-key (kbd "C-c h") 'consult-org-heading)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; Structure templates
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sp" . "src python"))

(setq org-confirm-babel-evaluate nil)
