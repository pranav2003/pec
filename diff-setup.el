;;;  -*- lexical-binding: t; -*-
;;; diff-setup.el -- Configurations for viewing diffs
;;;

(use-package diff
  :ensure
  :config
  ;; You cannot expect the syntax highlighting of themes to look
  ;; equally readabable against what typically are red and green
  ;; backgrounds.  This should be opt-in by default, not opt-out.
  (setq diff-font-lock-syntax nil))

(use-package ediff
  :config
  (setq ediff-split-window-function
	'split-window-vertically
	ediff-window-setup-function
	'ediff-setup-windows-plain))
