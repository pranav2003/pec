;;;  -*- lexical-binding: t; -*-
;;; books-setup.el -- Setup for reading books in Emacs
;;;

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :custom (nov-text-width 85)
  :hook (nov-mode . olivetti-mode))
