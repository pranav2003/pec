;;;  -*- lexical-binding: t; -*-
;;; package-setup.el -- Package management initialization
;;;

(require 'package)

(setq package-archives
      '(("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(setq package-archive-priorities
      '(("elpa" . 3)
        ("nongnu" . 2)
        ("melpa" . 1)))

(keybind "C-z p" package-list-packages)

(setq package-install-upgrade-builtin t)

(package-initialize)

(setq use-package-always-ensure t)
