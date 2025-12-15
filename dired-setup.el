;;;  -*- lexical-binding: t; -*-
;;; dired-setup.el -- configurations for Dired
;;;

(use-package dired-hide-dotfiles
  :hook (dired-after-readin . dired-hide-dotfiles--hide)
  :bind (:map dired-mode-map
	      ("," . dired-hide-dotfiles-mode)))

(defun dired-sysopen-file-at-point ()
  (interactive)
  (async-shell-command (concat "open " (dired-file-name-at-point)) "open (from dired)"))

(add-hook 'dired-mode-hook
	  (lambda ()
	    (keymap-set dired-mode-map (kbd ";")
			'dired-sysopen-file-at-point)))

(setq dired-listing-switches "-alh")
