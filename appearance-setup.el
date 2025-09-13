;;;  -*- lexical-binding: t; -*-
;;; appearance-setup.el -- Configurations for how Emacs looks
;;;

;; Use the wonderful ef-themes
(use-package ef-themes
  :config
  (setq ef-melissa-dark-palette-overrides
        '((prompt yellow-warmer))
	ef-dream-palette-overrides
	'((prose-done green-warmer)))
  (when-mac (setq ef-themes-to-toggle
		  '(ef-day ef-dream))))

(require-theme 'ef-themes)

(use-package doric-themes
  :ensure t)

(require-theme 'doric-themes)

(load-theme 'ef-maris-dark t)

;; Ensure fullscreen at startup
(when-mac
 (unless (frame-parameter nil 'fullscreen)
   (toggle-frame-fullscreen)))

;; Bigger font
(when-mac (set-face-attribute 'default nil :height 200))
(when-linux (set-face-attribute 'default nil :height 180))

;; Use the wonderful "Aporetic" font
(set-face-attribute 'default nil :family "Aporetic Sans Mono")

;; Truncate long lines (wrapping causes too much visual interference)
(set-default 'truncate-lines t)

;; Show the current time in the modeline
(display-time)

;; Smooth scrolling
(pixel-scroll-precision-mode 1)
