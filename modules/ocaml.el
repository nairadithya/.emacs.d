;; OCaml Setup  -*- lexical-binding: t; -*-
;; Major mode for editing Dune project files
(use-package dune
  :ensure t)

;; OCaml-specific LSP extensions via Eglot
(use-package ocaml-eglot
  :defer t
  :ensure t)

(use-package tuareg
  :ensure t
  :hook (tuareg-mode . ocaml-eglot-setup))

(use-package flymake
  :defer t
  :config
  (setq flymake-diagnostic-format-alist
        '((t . (origin code message)))))

(provide 'ocaml)
