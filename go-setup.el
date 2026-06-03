;;;  -*- lexical-binding: t; -*-
;;; go-setup.el -- configurations for Go(lang)
;;;

(use-package go-mode)

(let ((my-go-path (expand-file-name "/usr/local/go/bin")))
  (setenv "PATH" (concat my-go-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-go-path))

(let ((my-go-local-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-go-local-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-go-local-path))
