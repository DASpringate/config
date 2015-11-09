;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------


(add-to-list 'load-path "~/.emacs.d")

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'cider)
	(package-install 'cider))

(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)



(setq visible-bell t)
(blink-cursor-mode)
(ido-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq-default major-mode 'org-mode)
(setq initial-scratch-message "***Scratch***\n\n")
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

(desktop-save-mode 1)

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
	    kill-buffer-query-functions))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))) t)
 '(diff-added ((t (:foreground "cyan"))) t)
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))) t)
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil))))

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")

(setq ido-create-new-buffer 'always)


(defun revert-this-buffer ()
  (interactive)
  (revert-buffer nil t t)
  (message (concat "Reverted buffer " (buffer-name))))
(global-set-key [f6] 'revert-this-buffer)

(defun proced-settings ()
  (proced-toggle-auto-update t))




;; ----------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(setq auto-mode-alist (cons '("\\.json\\'" . js-mode) auto-mode-alist))

;; python setup

(add-to-list 'load-path
             "~/.emacs.d/emacs-for-python/extensions/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/emacs-for-python/extensions/yasnippet/snippets"))


(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(require 'epy-setup)
(require 'epy-python)
(require 'epy-completion)
(require 'epy-editing)
(require 'epy-bindings)
(require 'epy-nose)





(epy-setup-checker "pyflakes %f")
(epy-setup-ipython)
(global-hl-line-mode t)
(global-set-key (kbd "C-c !") 'python-shell-switch-to-shell)



;; ESS config
;(ess-toggle-underscore nil)

(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
        (delete-other-windows)
        (setq w1 (selected-window))
        (setq w1name (buffer-name))
        (setq w2 (split-window w1 nil t))
        (R)
        (set-window-buffer w2 "*R*")
        (set-window-buffer w1 w1name))))
(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))
(add-hook 'ess-mode-hook
          '(lambda ()
             (local-set-key [C-j] 'my-ess-eval)))
(add-hook 'inferior-ess-mode-hook
          '(lambda ()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))
(add-hook 'Rnw-mode-hook
          '(lambda ()
             (local-set-key [C-j] 'my-ess-eval)))
(require 'ess-site)
;; ESS Mode (.R file)
  (define-key ess-mode-map "\C-l" 'ess-eval-line-and-step)
  (define-key ess-mode-map "\C-p" 'ess-eval-function-or-paragraph-and-step)
  (define-key ess-mode-map "\C-r" 'ess-eval-region)
(setq ess-eval-visibly-p nil)

(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(dolist (hook '(markdown-mode-hook))
  (add-hook hook 
	    (lambda ()
	      (when buffer-file-name
		(add-hook 'after-save-hook
			  'check-parens
			  nil t))))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; easy spell check
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)


(show-paren-mode 1)

(load-theme 'tsdh-dark t)

(setq backup-directory-alist '(("." . "~/.saves")))

;; lisp stuff

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "/usr/bin/sbcl")
;; (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;; ; clhs loading
;; ; see www.hexstreamsoft.com/articles/getting-started-with-the-clhs
;; (load "/home/david/quicklisp/clhs-use-local.el" t)

;; clojure stuff

(load "~/.emacs.d/vendor/clojure")

;; Scala stuff

(load "~/.emacs.d/vendor/scala")

;; Haskell stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(org-agenda-files (quote ("~/webapps/grocircle/notes/gc_todo.org" "~/Dropbox/notes/work.org"))))


;; org mode 

(require 'org)
(setq org-startup-indented t)
(setq org-indent-mode t)
(setq org-completion-use-ido t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . org-mode))
;; clocking

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


;; Keybindings

(global-set-key [f1] 'ansi-term)
(global-set-key [f2] 'rgrep)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "M-o") 'other-window)
(add-hook 'proced-mode-hook 'proced-settings)
(global-set-key (kbd "C-c p") 'proced)
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M--" " <- ") ; R assign
(global-set-key "\M-m" " %>% ") ; R assign




