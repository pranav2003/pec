;;;  -*- lexical-binding: t; -*-
;;; lsp-setup.el -- Setup for Language Server Protocol integration
;;;

;; (use-package lsp-mode
;;   :defer t)

;; (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

;; (add-hook 'lsp-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key (kbd "M-.") 'lsp-find-definition)))

;; For error checking

;; (use-package flycheck
;;   :ensure t
;;   :defer t)

;; (setq lsp-completion-provider :none)  ;; don’t try to configure company

;; Map major mode to lsp server program
(with-eval-after-load 'eglot
  (dolist (el '((qml-mode . ("qmlls"))))
    (add-to-list 'eglot-server-programs el)))
