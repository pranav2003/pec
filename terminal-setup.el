;;;  -*- lexical-binding: t; -*-
;;; terminal-setup.el -- Setup for (multiple) terminals
;;;

;; Use the excellent `vterm' terminal emulator. Fetch it from Github
;; since it's not on `elpa' or `melpa'.
(use-package vterm
  :demand t
  :vc (:url "https://github.com/akermu/emacs-libvterm" :rev :newest)
  :config
  (setq vterm-timer-delay nil
	vterm-max-scrollback 10000)
  (define-key vterm-mode-map (kbd "C-z") nil)
  (define-key vterm-mode-map (kbd "C-z C-z") #'vterm--self-insert))

;; The Elisp code below implements an interface to making and managing
;; `vterm' buffers that I've called `vterm-session'.
;;
;; First, some helper functions that will be used in the definitions
;; of the key-bound `vterm-session/*' functions:

(defun collapse-tilde (path)
  "Un-expand the `~' character in a path, i.e. `string-replace' the full
home directory path with a `~/'."
  (string-replace (expand-file-name "~/") "~/" path))

(defmacro projectify (body)
  "If we're in a project, set the current working directory to the root
directory of that project. This \"projectifies\" the BODY by making it
think it's in the root of the project (if there is a project), which
causes functions that look out from the current directory to have vision
over the whole project tree"
  `(let ((proj (project-current nil)))
     (let ((default-directory (if proj
				  (project-root proj)
				default-directory)))
       ,body)))

(defun cwd ()
  "Get the current working directory. Implemented as `pwd' with the
returned string's tilde collapsed."
  (let ((inhibit-message t))
     (mapconcat #'identity
		(cdr (split-string
		      (collapse-tilde (pwd))
		      " "))
		" ")))

(defun cwd-project ()
  "Get the current working directory, or the root directory of the
current project (in the case that we're in a project). Implemented as
`pwd' with the returned string's tilde collapsed."
  (let ((inhibit-message t))
    (projectify
     (mapconcat #'identity
		(cdr (split-string
		      (collapse-tilde (pwd))
		      " "))
		" "))))

(defun buffer-names-matching-regexp (regexp)
  "Return a list of buffers whose names match `regexp'."
  (require 'cl-lib)
  (cl-remove-if-not
   (lambda (buf-name)
     (string-match-p regexp buf-name))
   (mapcar #'buffer-name (buffer-list))))

(defun vterm-session/go (dir &optional force-new)
  "Go to a `vterm' session for the directory DIR. If a session already
exists for DIR, jump to it; else, create a new vterm session in DIR.
If FORCE-NEW is `t', then a new session will be created unconditionally
(even if one already exists for DIR).

In the case that DIR is subdirectory of a project, the following logic
applies:

- If a `vterm' session already exists for DIR, then jump to it. Else,
- If a `vterm' session already exists for the project root directory,
  then jump to that. Else,
- Create a new `vterm' session for the project root directory.
│
└──> (This raises the question of how to create a new vterm instance
for DIR itself -- that is done by passing FORCE-NEW as `t'.)"
  (let ((default-directory dir)
	(vterm-buf-name (concat "*vterm* " dir)))
    (if (and (get-buffer vterm-buf-name) (not force-new))
	(pop-to-buffer vterm-buf-name)
      (let ((project-dir (cwd-project)))
	(if (and (not (equal dir project-dir))
		 (not force-new))
	    (let ((vterm-proj-buf-name (concat "*vterm* " project-dir)))
	      (if (get-buffer vterm-proj-buf-name)
		  (pop-to-buffer vterm-proj-buf-name)
		(projectify (vterm-other-window vterm-proj-buf-name))))
	  (vterm-other-window vterm-buf-name))))))

(defun vterm-session/in-vterm-buffer-for-dir-p (dir)
  "Check whether we're currently in a `vterm' session buffer for the
directory DIR."
  (string-match
   (rx string-start
       "*vterm* "
       (literal (collapse-tilde dir))
       (optional " <"
		 (one-or-more digit)
		 ">"))
   (buffer-name (current-buffer))))

;; Now the main event: wrappers around `vterm' which enable:
;; - creating new sessions with descriptive names
;;   (`vterm-session/create-*')
;; - switching to existsing sessions by way of a completing-read
;;   (`vterm-session/select')

(defun vterm-session/create-in-current-directory (arg)
  "Create or jump to a new `vterm' session in the current directory
(meaning, that from which this command was executed). If one already
exists there, then jump to it, else create a new session and name the
buffer after the current directory.

If a prefix argument is passed, then a new session will be created
unconditionally (even if one already exists for the current directory)."
  (interactive "P")
  (let ((current-directory (cwd)))
    (vterm-session/go current-directory
		      (or arg
			  (vterm-session/in-vterm-buffer-for-dir-p
			   current-directory)))))

(defun vterm-session/create-in-chosen-directory (arg)
  "Prompt for a directory in which to create a new, or jump to an
existing, `vterm' session.

If a prefix argument is passed, then a new session will be created
unconditionally."
  (interactive "P")
  (let ((dir (read-directory-name "Open vterm in: ")))
    (if dir
        (vterm-session/go dir arg))))

(defun vterm-session/select (arg)
  "Provide a completion menu of all active `vterm' sessions (whose names
match the format used by `vterm-session/go'), and jump to the selected
candidate.

If a prefix argument is passed, then the jump will happen in the current
window, instead of popping to another window"
  (interactive "P")
  (let ((vterm-buffer-names (buffer-names-matching-regexp
			     (rx string-start
				 "*vterm* "
				 (one-or-more nonl)
				 (optional " <"
					   (one-or-more digit)
					   ">")))))
    (if (not vterm-buffer-names)
	(message "No vterm sessions to choose from.")
      (let ((buf-name (completing-read
		       "Select vterm session: " vterm-buffer-names)))
	(if arg
	    (switch-to-buffer buf-name)
	  (pop-to-buffer buf-name
			 #'display-buffer-use-least-recent-window))))))

(keybinds
 "C-z ,"   vterm-session/create-in-current-directory
 "C-z M-," vterm-session/create-in-chosen-directory
 "C-z C-," vterm-session/select)

(defcustom vterm-session/normal-line-length 80
  "Number of columns considered to be a \"normal\" line length by the
command `vterm-session/toggle-long-lines'.")

(defcustom vterm-session/long-line-length 5000
  "Number of columns considered to be a \"long\" line length by the
command `vterm-session/toggle-long-lines'.")

(defun vterm-session/toggle-long-lines ()
  "Set the variable `vterm-min-window-width' to a large value if it's
small, or a small value if it's large. The values used for \"small\" and
\"large\" are determined by the variables `vterm-session/normal-line-length'
and `vterm-session/long-line-length'.

The rationale behind this command, and the aforementioned variables, is as
follows:

A known issue (URL `https://github.com/akermu/emacs-libvterm/issues/179') in
`vterm' makes it such that text which gets wrapped when fallling outside of
a frame boundary (due to resizing from the window manager) gets clipped out
of existence when the window is resized back to a size which should
re-include that text.

It's possible to work around this problem by setting
`vterm-min-window-width' to a number of columns that's large enough such
that the lines never wrap. However, this messes with the output of commands
like `ls', as with a large `vterm-min-window-width' the output will lie all
on a single line of text (since it isn't wrapping).

With all of this in mind, a good workaround workflow can be achieved by
toggling this long line length on when we need it (i.e. are about to have
long-lined text on screen which we may need to resize), and then back off
when we no longer need it (so that the output of common commands can wrap
normally)."
  (interactive)
  (message (format "%s" vterm-min-window-width))
  (if (< vterm-min-window-width vterm-session/long-line-length)
      (progn
	(setq vterm-min-window-width vterm-session/long-line-length)
	(message (format "Vterm: line length set to LONG (%s columns)."
			 vterm-session/long-line-length)))
    (progn
      (setq vterm-min-window-width vterm-session/normal-line-length)
      (message (format
		"Vterm: line length set to NORMAL (%s columns)."
		vterm-session/normal-line-length)))))

(keybind "C-z <" vterm-session/toggle-long-lines)
; a.k.a. "C-z S-,"
