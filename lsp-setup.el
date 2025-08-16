;;;  -*- lexical-binding: t; -*-
;;; lsp-setup.el -- Setup for Language Server Protocol integration
;;;

(use-package lsp-mode
  :defer t)

(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

(add-hook 'lsp-mode-hook
	  (lambda ()
	    (local-set-key (kbd "M-.") 'lsp-find-definition)))

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
