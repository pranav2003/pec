;;;  -*- lexical-binding: t; -*-
;;; package-setup.el -- Package management initialization
;;;

(require 'package)

(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(setq package-install-upgrade-builtin t)

(setq package-archive-priorities
      '(("gnu" . 10)
	("melpa-stable" . 5)))

(package-initialize)

(setq use-package-always-ensure t)
