(require 'org)

(defun my/org-aesthetics ()
  (require 'org-indent)
  ;; Aesthetique
  
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  )


(defun my/org-mode-setup ()
  (org-indent-mode)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (visual-fill-column-mode 1)
  (variable-pitch-mode 1)
  (my/org-aesthetics)
  (setq org-startup-indented t))
;; Use a specific PDF viewer (e.g., Evince, Okular, Zathura, etc.)

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.pdf\\'" . (lambda (file _link)
                         (start-process "sioyek" nil "sioyek" file)))
        ("\\.x?html?\\'" . default)))


(use-package org
  :hook (org-mode . my/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t)
  :bind
  ("M-j" . org-move-item-up)
  ("M-k" . org-move-item-down))

(use-package ox-typst
  :after org
  :custom
  (org-typst-from-latex-environment #'org-typst-from-latex-with-naive)
  (org-typst-from-latex-fragment #'org-typst-from-latex-with-naive))


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(provide 'org-config)
