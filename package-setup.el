;;;  -*- lexical-binding: t; -*-
;;; package-setup.el -- Package management initialization
;;;

(require 'package)

(setq package-archives
      '(("melpa-stable" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/stable-melpa/")
        ("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
        ("org"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/org/")
        ("gnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/gnu/")))

(setq package-install-upgrade-builtin t)

(setq package-archive-priorities
      '(("gnu" . 10)
	("melpa-stable" . 5)))

(package-initialize)

(setq use-package-always-ensure t)
