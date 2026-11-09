;;;  -*- lexical-binding: t; -*-
;;; ai-setup.el -- Setup for AI LLM integration
;;;


(use-package agent-shell
  :config
  (dolist (map '(agent-shell-mode-map
                 agent-shell-viewport-edit-mode-map
                 agent-shell-viewport-view-mode-map))
    (keymap-unset (symbol-value map) "C-<tab>" t)))
