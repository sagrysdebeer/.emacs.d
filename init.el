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

;; Remove security vulnerability
;; http://www.openwall.com/lists/oss-security/2017/09/11/1
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

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

;; references
;; http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
;; http://orgmode.org/org.html#Publishing-options
;; note org-publish-org-to-html will change to org-html-publish-to-html in Org-mode 8.0
(require 'org-publish)
(setq org-publish-project-alist
      '(
	("org-notes"
	 :base-directory "~/projects/github.io/src/"
	 :base-extension "org"
	 :publishing-directory "~/projects/github.io/pub/"
	 :recursive t
	 :publishing-function org-publish-org-to-html
	 :headline-levels 4
	 :html-preamble nil
	 :html-postamble nil
	 :author "Sagrys de Beer")
	("static-files"
	 :base-directory "~/projects/github.io/src/"
	 :base-extension "css\\|js\\|png\\|jpg\\|jpeg"
	 :publishing-directory "~/projects/github.io/pub/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("blog"
	 :components ("org-notes" "static-files"))))
