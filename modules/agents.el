(use-package agent-shell
    :ensure t
    :ensure-system-package
    ((pi . "npm install -g --ignore-scripts @earendil-works/pi-coding-agent")
     (pi-acp . "npm install -g pi-acp")))

(provide 'agents)
