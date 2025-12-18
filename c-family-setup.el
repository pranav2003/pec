;;;  -*- lexical-binding: t; -*-
;;; c-family-setup.el -- Configurations for C-like languages
;;;

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "stroustrup")
	    (eglot-ensure)))

(when-mac (setenv "CPLUS_INCLUDE_PATH" "/opt/homebrew/include"))

(defun project-find-subroot-cmake (dir)
  (when eglot-lsp-context
    (let ((root (locate-dominating-file dir "CMakeLists.txt")))
      (when root
        (cons 'transient root)))))

(add-hook 'project-find-functions #'project-find-subroot-cmake)
