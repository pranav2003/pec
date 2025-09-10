;;;  -*- lexical-binding: t; -*-
;;; package-setup.el -- Package management
;;;

(setq vterm-tramp-shells '((t login-shell) ("docker" "/bin/sh")))

;; Add ssh as proxy for sudo for the specified hostnames
(dolist (hostname '("sisyphus" "lightsail"))
  (add-to-list 'tramp-default-proxies-alist
               `(,(concat "\\`" hostname "\\'") "\\`root\\'" "/sshx:%h:")))
