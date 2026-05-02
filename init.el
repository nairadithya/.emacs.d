;; --- init.el --- Emacs configuration -*- lexical-binding: t; -*-
;; GC Optimization 
(setq gc-cons-threshold (* 50 1000 1000))
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 2 1000 1000))))

;; Custom file setup
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Load External Files
;; NOTE: Any file in modules/ needs to `(provide 'module)` at the end.
(defun load-module (name)
  (require (intern name)
           (expand-file-name (concat name ".el")
                             (concat user-emacs-directory "modules/"))))

;; Themes Loading
(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))

;; Emacs stuff
(load-module "cache")
(load-module "packages")
(load-module "visuals")
(load-module "utils")

;; Code
(load-module "treesitter")
(load-module "ocaml")
(load-module "rust")

;; Configuration
(load-module "meow-config")
(load-module "org-config")
(load-module "help-config")

;; use-package with package.el:
(use-package meow :ensure t
  :config
  (meow-setup)
  (meow-global-mode 1)
  )

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-show-shortcuts nil)
  )

(use-package emacs
  :custom
  (enable-recursive-minibuffers t)
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
  (save-place-mode 1) ;; Save the place your cursor was at for files.
  (auto-save-visited-mode 1) ;; Automatically saves buffers, with a timer.
  (initial-buffer-choice 'dashboard-open)
  ;; Settings
  (setq read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-ignore-case t
	;; Choose newer config over compiled/elisp
	load-prefer-newer t
	backup-by-copying t
	;; Flash frame (see visuals.el for the flash frame
	apropos-do-all t
	ediff-window-setup-function 'ediff-setup-windows-plain
	auto-save-visited-interval 30
	auto-save-default nil
	)
  )



(use-package transient 
  :demand t 
  :ensure t
  :config
  )

(use-package magit
  :defer t
  :ensure t
  :after transient
  :commands (magit-status) 
  :bind ("C-x g" . #'magit-status)
  :config (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

(use-package exec-path-from-shell
  :defer t
  :ensure t
  :init
  (exec-path-from-shell-initialize))

(use-package dired
  :ensure nil
  :config
  (add-hook 'dired-mode-hook #'dired-hide-details-mode))


(use-package compile
  :defer t
  :ensure nil
  :custom
  (compilation-always-kill t)
  (compilation-scroll-output t)
  (ansi-color-for-compilation-mode t)
  :config
  (put 'compile-command 'safe-local-variable #'stringp)
  )

(use-package project
  :ensure nil
  :config
  (setq project-switch-commands 'project-find-file)
  )

;; MINAD Stack
(use-package vertico
  :ensure t
  :config
  (vertico-mode)
  (setq vertico-count 20
	vertico-resize nil
	vertico-cycle t)
  (define-key minibuffer-local-map (kbd "<escape>") #'abort-recursive-edit)
  )

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) 

(use-package marginalia :ensure t :init (marginalia-mode))
(use-package typst-ts-mode
  :ensure t
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git"))

(use-package consult
  :ensure t
  :bind (("C-x b"   . consult-buffer)
         ("C-x C-r" . consult-recent-file)
         ("M-y"     . consult-yank-pop)      ; replaces default yank-pop
         ("M-s g"   . consult-grep)
         ("M-s l"   . consult-line)
         ("M-g i"   . consult-imenu)))

(use-package embark :ensure t)

(use-package consult-eglot
  :ensure t
  :after eglot
  :bind (:map eglot-mode-map
              ("M-g s" . consult-eglot-symbols)))

(use-package embark-consult
  :ensure t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  :hook (prog-mode . global-corfu-mode)
  :defer t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25
	doom-modeline-bar-width 2
	doom-modeline-icon t
	doom-modeline-buffer-encoding nil 
	doom-modeline-modal-modern-icon t
	doom-modeline-major-mode-icon t
	doom-modeline-buffer-file-name-style 'truncate-upto-project
  ))
