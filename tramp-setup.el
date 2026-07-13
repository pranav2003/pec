;;;  -*- lexical-binding: t; -*-
;;; tramp-setup.el -- Setup for TRAMP
;;;

(use-package tramp
  :ensure t
  :config
  (setq
   remote-file-name-inhibit-cache nil
   vc-handled-backends '(Git)
   remote-file-name-inhibit-locks t))

(setq vterm-tramp-shells '((t login-shell) ("docker" "/bin/bash")))

;; Add ssh as proxy for sudo for the specified hostnames
(dolist (hostname '("lightsail"))
  (add-to-list 'tramp-default-proxies-alist
               `(,(concat "\\`" hostname "\\'") "root" "/sshx:%h:")))

(when-mac (add-to-list 'tramp-default-proxies-alist
		       '("\\`sisyphus\\'" "\\`root\\'" "/sshx:%h:")))
