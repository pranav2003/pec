;;;  -*- lexical-binding: t; -*-
;;; csharp-setup.el -- Configurations for C#
;;;

(add-hook 'csharp-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (setq tab-width 4)
	    (eglot-ensure)))
(setq csharp-ts-mode-hook csharp-mode-hook)

(add-to-list 'exec-path "~/.dotnet/tools" t)

(use-package csproj-mode)

;; Use csproj files as the indicator for project directories for eglot
(defun project-find-subroot-csproj (dir)
  (let ((root (locate-dominating-file dir 
				      (lambda (dir)
					(not (null (directory-files dir nil "\\.csproj\\'")))))))
    (when root
      (cons 'transient root))))

(add-hook 'project-find-functions #'project-find-subroot-csproj)

