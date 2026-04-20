;;;  -*- lexical-binding: t; -*-
;;; programming-setup.el -- Customizations for coding
;;;

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package cape
  :bind ("M-/" . cape-dabbrev))

(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode 1)
	    (setq-local completion-at-point-functions '(cape-dabbrev cape-keyword cape-file))
	    (setq captain-predicate
		  (lambda () (nth 8 (syntax-ppss (point)))))))

;; Map major mode to lsp server program
(with-eval-after-load 'eglot
  (dolist (el '((qml-mode . ("qmlls"))
		(c++-ts-mode . ("clangd" "--log=verbose"))))
    (add-to-list 'eglot-server-programs el)))

(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
