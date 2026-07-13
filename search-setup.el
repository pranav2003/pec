;;;  -*- lexical-binding: t; -*-
;;; search-setup.el -- Configurations for searching through text
;;;

(use-package isearch
  :ensure nil
  :config
  ;; Match sequential tokens regardless of what may be between them.
  ;; (Works within lines, not across them)
  (setq search-whitespace-regexp ".*?")
  (setq isearch-lax-whitespace t)
  (setq isearch-regexp-lax-whitespace nil)
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "(%s/%s) ")
  (setq lazy-count-suffix-format nil))
