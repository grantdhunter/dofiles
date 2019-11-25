(defvar  super-emacs--my-keyboard-bindings
  '(("C-\," . neotree-toggle)
    ("C-c M-x" . execute-extended-command)
    ("M-x" . helm-M-x)
    ("C-x b" . helm-mini)
    ("C-x C-b" . helm-buffers-list)
    ("C-x C-f" . helm-find-files)
    ("C-x C-r" . helm-recentf)
    ("C-c p h" . helm-projectile)
    ("M-y" . helm-show-kill-ring)
    ("C-S-<up>" . buf-move-up)
    ("C-S-<down>" . buf-move-down)
    ("C-S-<left>" . buf-move-left)
    ("C-S-<right>" . buf-move-right)
    ("C--" . undo)
    ("C-x p" . previous-multiframe-window)
    ("s--" . text-scale-decrease)
    ("s-=" . text-scale-increase)
    ("C-c m" . magit-status)
    ("C-c g" . helm-projectile-grep)
    ("C-S-s" . helm-occur)
    ("C-c b" . helm-semantic-or-imenu)
    ("C-c j" . helm-all-mark-rings)
    ("C-a" . crux-move-beginning-of-line)
    ("C-c g" . writegood-mode)
    ("M-g o" . dumb-jump-go-other-window)
    ("M-g j" . dumb-jump-go)
    ("M-g q" .dump-jump-quick-look)
    ("M-g i" . dumb-jump-go-prompt)
    ("M-g x" . dumb-jump-go-prefer-external)
    ("M-g z" . dumb-jump-go-prefer-external-other-window)
    ("C-}" . mc/mark-next-like-this)
    ("C-{" . mc/mark-previous-like-this)
    ("C-|" . mc/mark-all-like-this)
    ("<F5>" . super-emacs-reload-current-file)
    ))

(defun super-emacs-apply-keyboard-bindings (pair)
  "Apply keyboard-bindings for supplied list of key-pair values"
  (global-set-key (kbd (car pair))
                  (cdr pair)))

(mapc 'super-emacs-apply-keyboard-bindings
      super-emacs--my-keyboard-bindings)

(add-hook 'python-mode-hook (lambda ()
                           (local-set-key (kbd "C-c i") (lambda () (interactive) (
                                                                   insert "import pdb; pdb.set_trace()")))))
(defun super-emacs-reload-current-file ()
  "Reload the file loaded in current buffer from the disk"
  (interactive)
  (cond (buffer-file-name (progn (find-alternate-file buffer-file-name)
                                 (message "File reloaded")))
        (t (message "You're not editing a file!"))))