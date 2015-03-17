;; clojure

(require 'ac-nrepl)
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))

;; cider
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode 'ac-nrepl-setup)
(setq cider-repl-pop-to-buffer-on-connect t)
(setq cider-popup-stacktraces t)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-history-file "~/.emacs.d/cider-history")
(setq cider-repl-wrap-history t)
(setq nrepl-hide-special-buffers t)
(setq cider-auto-select-error-buffer t)

(add-hook 'cider-repl-mode-hook 'subword-mode 'ac-nrepl-setup)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'cider-turn-on-eldoc-mode)
(add-to-list 'ac-modes 'cider-mode)
(add-to-list 'ac-modes 'cider-repl-mode)

(defun turn-on-paredit () (paredit-mode t))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
