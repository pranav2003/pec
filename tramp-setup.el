;;;  -*- lexical-binding: t; -*-
;;; tramp-setup.el -- Setup for TRAMP
;;;

(setq vterm-tramp-shells '((t login-shell) ("docker" "/bin/sh")))

;; Add ssh as proxy for sudo for the specified hostnames
(dolist (hostname '("lightsail"))
  (add-to-list 'tramp-default-proxies-alist
               `(,(concat "\\`" hostname "\\'") "root" "/sshx:%h:")))

(when-mac (add-to-list 'tramp-default-proxies-alist
		       ("\\`sisyphus\\'" "\\`root\\'" "/sshx:%h:")))
