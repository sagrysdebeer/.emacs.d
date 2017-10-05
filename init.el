(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;;(load-theme 'zenburn t)
(load-theme 'gruvbox t)

(setq inferior-lisp-program "sbcl")

(setq c-default-style "k&r"
      c-basic-offset 4)

(setq org-log-done 'time)
(setq org-export-with-sub-superscripts '{})

(defun zoom-in ()
  (interactive)
  (text-scale-increase 1))

(defun zoom-out ()
  (interactive)
  (text-scale-decrease 1))

(global-set-key (kbd "<C-wheel-up>") 'zoom-in)
(global-set-key (kbd "<C-wheel-down>") 'zoom-out)

(global-set-key (kbd "C-`") 'call-last-kbd-macro)

;; following 2 functions from here
;; https://www.emacswiki.org/emacs/DuplicateLines

(defun uniquify-region-lines (beg end)
    "Remove duplicate adjacent lines in region."
    (interactive "*r")
    (save-excursion
      (goto-char beg)
      (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
        (replace-match "\\1"))))

(defun uniquify-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))
