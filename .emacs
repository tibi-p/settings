(save-place-mode 1)
(setq column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq js-indent-level 2)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
             ;'("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/notes/org-roam-archive"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(require 'org-roam)

(setq org-log-done 'time)
(setq org-return-follows-link t)

(setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            ;; #'org-roam-unlinked-references-section
            ))

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(setq org-roam-dailies-directory "daily/")

(setq todo-path "~/dev/notes/org/todo/")
(setq agenda-files
 '("Development.org" "Entertainment.org" "Education.org" "Therapy.org" "Coding.org" "Hobby.org" "WellBeing.org" "Errands.org" "Chores.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (mapcar (lambda (filename) (concat todo-path filename)) agenda-files))
 '(org-priority-lowest 90)
 '(package-selected-packages
   '(magit org-roam-ui org-roam-server elisp-format ## command-log-mode org ox-twbs org-roam rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
