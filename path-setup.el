;;;  -*- lexical-binding: t; -*-
;;; path-setup.el -- Settings for load path and exec path
;;;

(use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize))
