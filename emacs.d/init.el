;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)


;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(use-package yasnippet
  :ensure t)

(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/.pyenv/versions"))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((js-mode . lsp-deferred)
         (rust-mode . lsp-deferred))
  :commands lsp)

(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  )
(use-package company-lsp
    :ensure t
    :commands company-lsp
    :hook (after-init-hook . global-flycheck-mode)
    :init
    (setq company-dabbrev-downcase nil)
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 1)
    (global-company-mode)
    :config
    (push 'company-lsp company-backends)
     )
(use-package helm
  :ensure t
  :bind(("M-x" . helm-M-x)
        ("C-x b" . helm-mini)
        ("C-x C-b" . helm-buffers-list)
        ("C-x C-f" . helm-find-files)
        ("C-x C-r" . helm-recentf)
        ("M-y" . helm-show-kill-ring))
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-autoresize-max-height 20)
  (setq helm-autoresize-max-height 20)
  (helm-autoresize-mode 1)
  :commands helm-lsp-workspace-symbol
  )
(use-package helm-lsp
  :ensure t
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-global-workspace-symbol)
  )

(use-package helm-projectile
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (setq projectile-enable-caching t
        projectile-indexing-method 'native
        projectile-completion-system 'helm
        projectile-switch-project-action 'helm-projectile
        projectile-globally-ignored-files
        (append '(".pyc"
                  ".class"
                  "~"
                  "/node_modules")
                projectile-globally-ignored-files))
  (projectile-mode)
  (helm-projectile-on)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))


(use-package semantic
  :ensure t
  :config
  (semantic-mode 1)
  (global-semantic-stickyfunc-mode 1)
  )

(use-package material-theme
  :ensure t)

;;(font-lock-add-keywords 'lisp-mode '(("\'.*\'" 0 'font-lock-single-quote-string-face t)))

(use-package multiple-cursors
  :ensure t
  :bind(
    ("C-}" . mc/mark-next-like-this)
    ("C-{" . mc/mark-previous-like-this)
    ("C-|" .  mc/mark-all-like-this)
        ))


(use-package powerline
    :ensure t)


(use-package flycheck
    :ensure t)
(use-package rainbow-delimiters
    :ensure t)
(use-package magit
  :ensure t
  :bind (("C-c m" . magit-status)))




(use-package toml-mode
    :ensure t)
(use-package rust-mode
    :ensure t)
(use-package terraform-mode
    :ensure t)
(use-package company-terraform
    :ensure t)
(use-package jinja2-mode
    :ensure t)
(use-package json-mode
    :ensure t)
(use-package json-snatcher
  :ensure t)


(use-package yaml-mode
    :ensure t)

(add-to-list 'auto-mode-alist '("\\.lisp\\'" . emacs-lisp-mode))
(require 'uniquify)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq frame-title-format "%F %b ")
(setq uniquify-buffer-name-style 'forward)

(show-paren-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-auto-revert-mode t)
(global-linum-mode)
(global-whitespace-mode)

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(setq gc-cons-threshold 20000000)
(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq vc-follow-symlinks t)
(setq confirm-kill-emacs 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq lazy-highlight-cleanup nil)
(setq whitespace-line-column 500)
(setq read-process-output-max 8192)
(setq-default indent-tabs-mode
              nil)

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (select-frame frame)
            (load-theme 'material t)
            (set-frame-size (selected-frame) 150 48)))
    (load-theme 'material t))


(add-hook 'eww-mode-hook 'scroll-lock-mode)

;;cleanup buffers
(setq clean-buffer-list-delay-special 900)
(defvar clean-buffer-list-timer nil)
(setq clean-buffer-list-timer (run-at-time t 7200 'clean-buffer-list))
;; kill everything, clean-buffer-list is very intelligent at not killing
;; unsaved buffer.
(setq clean-buffer-list-kill-regexps '("^.*$"))

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;Enable powerline
(powerline-center-theme)
(setq powerline-default-separator 'slant)

;keybindings
(global-set-key (kbd "C--") 'undo)
(global-set-key (kbd "C-x p") 'previous-multiframe-window)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-checker-error-threshold 1000)
 '(package-selected-packages
   '(lsp-jedi django-snippets company helm-lsp company-lsp pyvenv json-snatcher package-lint helm-slime slime slime-company slime-repl-ansi-color helm-projectile web-mode py-autopep8 yasnippet lsp-ui uniquify lsp-helm lsp-company yaml-mode use-package toml-mode rust-mode rainbow-delimiters projectile powerline multiple-cursors material-theme magit lsp-mode json-mode jinja2-mode gnu-elpa-keyring-update flycheck company-terraform)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
