(setq inhibit-startup-message t)
(if (functionp 'menu-bar-mode) (menu-bar-mode -1))
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;; Remove security vulnerability
;; http://www.openwall.com/lists/oss-security/2017/09/11/1
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

;;(load-theme 'zenburn t)
(if (locate-file "gruvbox-theme.el" custom-theme-load-path '("" "c"))
    (load-theme 'gruvbox t))

(setq inferior-lisp-program "sbcl")

(setq c-default-style "bsd"
      c-basic-offset 4)

(add-hook 'sgml-mode-hook
          (lambda ()
            ;; Default indentation to 2, but let SGML mode guess, too.
            (set (make-local-variable 'sgml-basic-offset) 2)
            (sgml-guess-indent)))

(setq-default indent-tabs-mode nil)

(setq org-log-done 'time)
(setq org-export-with-sub-superscripts '{})

(setq deft-extensions '("org" "txt" "tex"))

(require 'deft nil 'noerror)

(defun zoom-in ()
  (interactive)
  (text-scale-increase 1))

(defun zoom-out ()
  (interactive)
  (text-scale-decrease 1))

;; on windows its C-wheel-up and C-wheel-down?
(global-set-key (kbd "<C-mouse-4>") 'zoom-in)
(global-set-key (kbd "<C-mouse-5>") 'zoom-out)

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

;; chsarp stuff

(defun my-csharp-mode-hook ()
  (omnisharp-mode)
  (flycheck-mode)
  (local-set-key (kbd "<C-tab>") 'omnisharp-auto-complete))

(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)


;; https://unix.stackexchange.com/questions/45125/how-to-get-current-buffers-filename-in-emacs
;; current solution to creating links in my mini zettelkasten

(defun file-name-to-kill-ring ()
  "Put the full path of the current buffer in the kill-ring."
  (interactive)
  (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(require 'subr-x)

(defun zk-get-title ()
  (let* ((regexp "^[[:space:]]*#\\+TITLE:[[:space:]]*\\(.*?\\)[[:space:]]*$")
         (start (point-min))
         (string (buffer-substring-no-properties start
                                                 (min (+ start 150) (point-max)))))
    (if (string-match regexp string 0)
        (replace-regexp-in-string "#\\+TITLE:[[:space:]]" "" (string-trim (match-string 0 string)))
      nil)))

(defun zk-insert-self-link()
  (interactive)
  (let* ((name (buffer-file-name (window-buffer (minibuffer-selected-window))))
         (title (zk-get-title)))
    (if (and name title)
        (save-excursion
          (insert (concat "[[" (replace-regexp-in-string "/home/[.]*/" "~/" name) "][" title "]]")))
      nil)))
