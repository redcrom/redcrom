
;; NOTE: init.el is now generated from Emacs.org. Please edit that file
;;       in Emacs and init.el will be generated automatically!
;; You will most likely need to adjust this font size for your system!
;; The default is 800 kilobytes. Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))
(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar
;; Set up the visible bell
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "a"  '(:ignore a :which-key "agenda")
    "aa" '(org-agenda :which-key "agenda")
    "ac" '(org-capture :which-key "capture")
    "at" '(org-todo-list :which-key "todo list")
    "ai" '(org-time-stamp :which-key "insert time stamp")
    "af" '(org-agenda-file-to-front :which-key "add document to agenda"))

  (efs/leader-keys
    "f"  '(:ignore f :which-key "find")
    "ff" '(find-file :which-key "find file")
    "fc" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/init.el"))) 
    "fw" '(lambda () (interactive) (find-file (expand-file-name "~/Documents/work.org"))))

  (efs/leader-keys
    "b"  '(:ignore b :which-key "buffer")
    "bb" '(switch-to-buffer :which-key "switch buffer")
    "bk" '(kill-this-buffer :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next buffer")
    "bp" '(previous-buffer :which-key "previous buffer")
    "br" '(revert-buffer :which-key "reload buffer"))

  (efs/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme"))

  (efs/leader-keys
    "e"  '(:ignore e :which-key "eval")
    "eb" '(eval-buffer :which-key "eval buffer")
    "er" '(eval-region :which-key "eval region")))

(which-key-add-key-based-replacements
  "SPC f c" ".emacs.el"
  "SPC f w" "work.org")

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package doom-themes
  :init
  (load-theme 'doom-dracula t))
(use-package elfeed
  :ensure t
  :config
  (setq rmh-elfeed-org-files (list "~/Documents/elfeed.org"))
  (elfeed-org)
  (defun elfeed-mark-all-as-read ()
    (interactive)
    (mark-whole-buffer)
    (elfeed-search-untag-all-unread))
  (defalias 'elfeed-toggle-star
    (elfeed-expose #'elfeed-search-toggle-all 'star))
  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury) 
              ("m" . elfeed-toggle-star)
              ("M" . elfeed-toggle-star)))
(use-package elfeed-goodies
  :ensure t
  :config
  (elfeed-goodies/setup))
(use-package all-the-icons)
(use-package org-bullets
  :ensure t
  :init
  (setq org-bullets-bullet-list
        '("Ӕ" "₿" "Ω" "♠" "♣" "♥" "♦"))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-dracula))
 '(custom-safe-themes
   '("48042425e84cd92184837e01d0b4fe9f912d875c43021c3bcb7eeb51f1be5710" "2ba86144b8790dd8d2323426a3c8476c6f33a8314723b304981a70f29024d908" default))
 '(elfeed-feeds '("https://thehackernews.com/"))
 '(org-agenda-files '("/home/mentok/Documents/work.org"))
 '(package-selected-packages
   '(elfeed-goodies elfeed smart-mode-line doom-modeline org-bullets all-the-icons doom-themes evil-collection evil general which-key auto-package-update)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
