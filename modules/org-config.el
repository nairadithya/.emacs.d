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
  ("M-k" . org-move-item-up)
  ("M-j" . org-move-item-down)
  ("M-k" . org-move-subtree-up)
  ("M-j" . org-move-subtree-down)
  ("C-c o A". org-agenda)
  )

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

(defcustom journal-directory "~/notes/journal/"
  "Journal Directory"
  :type 'directory)

(setq notes-directory "~/notes/")

(defvar journal-filename-format "%Y_%m_%d.org")
(defvar journal-boilerplate-format "** %A, %e %B %Y\n*** Win\n*** Log\n*** Feelings\n*** Ideas / Insights\n*** Next Step\n")

(defun journal-today-filename ()
  (format-time-string journal-filename-format (current-time))
  )  

(defun journal--init-entry (filepath)
  (write-region (format-time-string journal-boilerplate-format (current-time)) nil filepath)
  (find-file filepath))

(defun journal-today-create-entry ()
  (interactive)
  (setq journal-file-path (expand-file-name (concat journal-directory (journal-today-filename))))
  (if (file-exists-p journal-file-path)
      (find-file journal-file-path)
    (journal--init-entry journal-file-path)))

(defun journal-search-entries ()
  (interactive)
  (consult-ripgrep journal-directory)) 

(use-package org-capture
  :ensure nil
  :config
  (setq org-capture-templates
	'(
	  ("e" "College evaluation" entry (file+headline "~/notes/events.org" "Evaluations") "* %?\nSCHEDULED: %^T")
	  ("i" "Quick Inbox Capture" entry (file+headline "~/notes/todo.org" "Inbox") "* %^{Enter the thing to capture:}")
	  )))

(provide 'org-config)
