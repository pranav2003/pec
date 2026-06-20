;;;  -*- lexical-binding: t; -*-
;;; windows-setup.el -- Window management
;;;

(defun split-window-below-and-focus ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun split-window-right-and-focus ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun switch-to-previous-window ()
  (interactive)
  (select-window (or (get-mru-window t t t)
                     (user-error "No previous window found"))))

(use-package emacs
  :config
  ;; Easy window switch
  (keybinds "C-<tab>" other-window
            "M-o" switch-to-previous-window
            "C-x 2" split-window-below-and-focus
            "C-x 3" split-window-right-and-focus
            "C-S-i" enlarge-window
            "C-S-d" shrink-window
	    "C-S-M-i" enlarge-window-horizontally
            "C-S-M-d" shrink-window-horizontally))

(use-package ace-window
  :config
  (keybinds "C-z C-w" ace-window
            "C-z M-w" ace-swap-window))

;; Quickdraw
;; ---------
;; Clear out unwanted buffers and windows with repeatable keys

(defun multiple-windows-in-frame-p ()
  "Return `t' if the selected frame contains multiple windows,
and `nil' if it contains only 1 window"
  (listp (car (window-tree))))

(defun quickdraw/kill-buffer-and-delete-window-dwim ()
  "Kill the currently-selected buffer and, if the window that displayed
that buffer is one of multiple windows in the frame, then delete that
window."
  (interactive)
  (kill-buffer)
  (if (multiple-windows-in-frame-p)
      (delete-window)))

(defun quickdraw/kill-current-buffer ()
  "Kill the currently-selected buffer. Don't prompt the user
(unlike \"M-x kill-buffer\")."
  (interactive)
  (kill-buffer))

;; The following commands are all aliases, which are needed so that we
;; can put them in the `quickdraw-repeat-map' without affecting the
;; underlying functions they're aliasing to.

(defun quickdraw/delete-window ()
  "Alias for \"(delete-window)\"."
  (interactive)
  (delete-window))

(defun quickdraw/delete-other-windows ()
  "Alias for \"(delete-other-windows)\"."
  (interactive)
  (delete-other-windows))

(defun quickdraw/other-window ()
  "Alias for \"(other-window 1)\"."
  (interactive)
  (other-window 1))

(defun quickdraw/other-window-backwards ()
  "Alias for \"(other-window -1)\"."
  (interactive)
  (other-window -1))

(defvar-keymap quickdraw-repeat-map
  :repeat t
  "k" #'quickdraw/kill-buffer-and-delete-window-dwim
  "K" #'quickdraw/kill-current-buffer
  "d" #'quickdraw/delete-window
  "D" #'quickdraw/delete-other-windows
  "o" #'quickdraw/other-window
  "O" #'quickdraw/other-window-backwards)

(keybinds "C-z k" quickdraw/kill-buffer-and-delete-window-dwim
	  "C-z o" quickdraw/other-window)
