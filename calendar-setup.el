;;;  -*- lexical-binding: t; -*-
;;; calendar-setup.el -- Configurations for the built-in Calendar
;;;

(use-package calendar
  :bind (("C-z c" . calendar)
	 (:map calendar-mode-map
               ("y" . calendar-yank-date)))
  :config
  (defun calendar-yank-date ()
    "Copy the date at point in mm-dd-yyyy format to the kill ring."
    (interactive)
    (let* ((date (calendar-cursor-to-date t))
           (month (calendar-extract-month date))
           (day   (calendar-extract-day date))
           (year  (calendar-extract-year date))
           (str   (format "%02d-%02d-%04d" month day year)))
      (kill-new str)
      (message "Yanked: %s" str))))
