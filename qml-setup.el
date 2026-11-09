;;;  -*- lexical-binding: t; -*-
;;; qml-setup.el -- Configurations for Qt QML editing
;;;

(unless (fboundp 'c-ts-mode-comment-setup)
  (defun c-ts-mode-comment-setup () nil))

(use-package qml-ts-mode
  :vc (:url "https://github.com/xhcoding/qml-ts-mode" :branch "main")
  :mode "\\.qml\\'"
  :custom
  (setq qml-ts-mode-indent-offset 4))

;; (add-hook 'js-mode-hook
;; 	  (=> (setq js-indent-level 2)))

;; (add-hook 'typescript-ts-mode-hook
;; 	  (=> (setq typescript-ts-mode-indent-offset 4)))
