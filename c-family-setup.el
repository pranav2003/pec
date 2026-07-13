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
(defun find-outermost-dominating-file (start-dir filename)
  "Return the outermost path to FILENAME found above START-DIR, or nil."
  (let ((current-dir (expand-file-name start-dir))
        (last-found nil))
    (while-let ((found (locate-dominating-file current-dir filename)))
      (setq last-found found)
      (let ((parent (file-name-directory (directory-file-name found))))
        (if (or (not parent)
                (string= (expand-file-name parent) (expand-file-name found)))
            (setq current-dir nil) ; break loop
          (setq current-dir parent))))
    last-found))

(defun project-find-subroot-cmake (dir)
  (let ((root (find-outermost-dominating-file dir "CMakeLists.txt")))
    (when root
      (cons 'transient root))))

(add-hook 'project-find-functions #'project-find-subroot-cmake)
