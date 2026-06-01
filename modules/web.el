(use-package web-mode :ensure t)

(setq auto-mode-alist
      (append '((".*\\.astro\\'" . web-mode))
              auto-mode-alist))

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs
               '(astro-mode . ("astro-ls" "--stdio"
                               :initializationOptions
                               (:typescript (:tsdk "./node_modules/typescript/lib")))))
  :init
  ;; auto start eglot for astro-mode
  (add-hook 'astro-mode-hook 'eglot-ensure))

(provide 'web)
