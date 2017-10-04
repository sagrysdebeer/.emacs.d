(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(load-theme 'zenburn t)

(setq inferior-lisp-program "sbcl")

(setq c-default-style "k&r"
      c-basic-offset 4)

(setq org-log-done 'time)
