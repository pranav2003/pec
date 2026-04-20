;;;  -*- lexical-binding: t; -*-
;;; c-family-setup.el -- Configurations for C-like languages
;;;

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (eglot-ensure)
	    (setq indent-tabs-mode nil)
	    (setq c-ts-mode-indent-offset 4)))
(setq c-ts-mode-hook c-mode-common-hook)
(setq c++-ts-mode-hook c-mode-common-hook)

(setq c-electric-pound-behavior 'alignleft)

(when-mac (setenv "CPLUS_INCLUDE_PATH" "/opt/homebrew/include"))

;; Use CMakeLists.txt as the indicator for project directories for eglot
(defun project-find-subroot-cmake (dir)
  (let ((root (locate-dominating-file dir "CMakeLists.txt")))
    (when root
      (cons 'transient root))))

(add-hook 'project-find-functions #'project-find-subroot-cmake)
