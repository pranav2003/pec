;;;  -*- lexical-binding: t; -*-
;;; rust-setup.el -- Configurations for Rust
;;;

(use-package rustic
  :ensure t
  :defer t)

(use-package company
  :ensure t
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))
