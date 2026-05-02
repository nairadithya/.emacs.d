(use-package rust-mode
  :ensure t
  :hook (rust-mode . eglot-ensure)
  )

(setq rust-format-on-save t)

(provide 'rust)
