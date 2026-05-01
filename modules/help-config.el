(defun my/help-mode-setup ()
  (variable-pitch-mode 1)
  (visual-fill-column-mode 1)
  (display-line-numbers-mode -1)
  (setq-local line-spacing 0.15)        
  (setq-local visual-fill-column-width 90)) 

(add-hook 'help-mode-hook #'my/help-mode-setup)

(add-hook 'Info-mode-hook #'my/help-mode-setup)
(provide 'help-config)
