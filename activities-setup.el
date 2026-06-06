;;;  -*- lexical-binding: t; -*-
;;; activities-setup.el -- Save and restore sessions (a bit like `tmux')
;;;

(use-package activities
  :init
  (activities-mode)
  (activities-tabs-mode)
  ;; Prevent `edebug' default bindings from interfering.
  (setq edebug-inhibit-emacs-lisp-mode-bindings t)
  :bind
  (("C-z A n" . activities-new)
   ("C-z A d" . activities-define)
   ("C-z A a" . activities-resume)
   ("C-z A s" . activities-suspend)
   ("C-z A k" . activities-kill)
   ("C-z A SPC" . activities-switch)
   ("C-z A b" . activities-switch-buffer)
   ("C-z A g" . activities-revert)
   ("C-z A l" . activities-list)))
