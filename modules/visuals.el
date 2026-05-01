;; --- visuals.el --- Mode Settings  -*- lexical-binding: t; -*-

;; UI Chrome
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)

;; Startup
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil)

;; Frame
(setf display-line-numbers 'relative)
(add-to-list 'default-frame-alist '(internal-border-width . 16))

;; Theme
(use-package ef-themes
  :ensure t
  :init
  (ef-themes-take-over-modus-themes-mode 1)
  :config
  (setq modus-themes-mixed-fonts t
        modus-themes-italic-constructs t)
  (modus-themes-load-theme 'ef-dream))

;; Fonts — defined early, re-applied after init and after any theme load
(defun my/setup-faces ()
  (set-face-attribute 'default        nil :font "BlexMono Nerd Font" :height 160)
  (set-face-attribute 'fixed-pitch    nil :font "BlexMono Nerd Font" :height 160)
  (set-face-attribute 'variable-pitch nil :font "IBM Plex Serif"     :weight 'regular))

(add-hook 'server-after-make-frame-hook #'my/setup-faces)
(add-hook 'after-init-hook #'my/setup-faces)
(advice-add 'load-theme :after (lambda (&rest _) (my/setup-faces)))

;; Visual fill column
(use-package visual-fill-column
  :ensure t
  :custom
  (visual-fill-column-width 80)
  (visual-fill-column-center-text t))

;; Modeline
(force-mode-line-update t)

;; Flash on error with theme colour
(setq visible-bell nil
      ring-bell-function
      (lambda ()
        (let ((orig  (face-background 'mode-line))
              (flash (face-foreground 'font-lock-keyword-face)))
          (set-face-background 'mode-line flash)
          (run-with-timer 0.2 nil
                          (lambda ()
                            (set-face-background 'mode-line orig))))))

;; Disable line numbers in certain modes
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(provide 'visuals)
