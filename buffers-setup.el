;;;  -*- lexical-binding: t; -*-
;;; buffers-setup.el -- Buffer management
;;;

(use-package ibuffer
  :config
  (keybind "C-x C-b" ibuffer-other-window))

;; Delete up to / in filepath
(defun backward-kill-filepath ()
  "Delete backward up to the previous slash in minibuffer or string."
  (interactive)
  (let ((pt (point)))
    (search-backward "/" (minibuffer-prompt-end) t)
    (if (= (- pt 1) (point))
	(search-backward "/" (minibuffer-prompt-end) t))
    (forward-char)
    (delete-region (point) pt)))

(defun my-backward-kill-filepath-minibuffer-setup ()
  "Bind `backward-kill-filepath` in the current find-file minibuffer only."
  (when (member this-command '(find-file find-file-other-window find-alternate-file dired))
    (let ((map (copy-keymap (current-local-map))))
      (define-key map (kbd "C-<backspace>") #'backward-kill-filepath)
      (use-local-map map))))

(add-hook 'minibuffer-setup-hook 'my-backward-kill-filepath-minibuffer-setup)

