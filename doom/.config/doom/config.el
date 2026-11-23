;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "David Roertson"
      user-mail-address "david.robertson@octopusmoney.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; See https://github.com/hlissner/doom-emacs/issues/4242#issuecomment-724356280
(setq doom-localleader-key ",")
(setq evil-snipe-override-evil-repeat-keys nil)

(map! :leader :desc "Call command (M-x)" "SPC" 'execute-extended-command
              :desc "Split horizontally" "w -" 'evil-window-split
              :desc "Split vertically" "w |" 'evil-window-vsplit
              )

;; Xmouse mode in terminal?
;; https://www.reddit.com/r/emacs/comments/s3lwtj/comment/ht3plwy/
;(unless window-system
;  (require 'mouse)
;  (xterm-mouse-mode t)
;  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
;  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
;  )

(after! magit
  (setq git-commit-summary-max-length 65)
  ;; Magit: show assume-unchanged files in status view
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-assume-unchanged-files 'magit-insert-staged-changes 'after)
  ;; (setq magit-show-long-lines-warning nil)

  )

;; Magit: 
;; Show most recently updated branches first
;; and stop vertico from reordering them
(after! (magit vertico)
  (setq magit-list-refs-sortby "-committerdate")
  
  (defadvice! +magit--preserve-ref-order-a (fn &rest args)
    :around #'magit-completing-read
    (let ((vertico-sort-function nil))
            (apply fn args))))

;; Magit: press h during rebase to reset author
;; https://gist.github.com/danielmartin/34bc36dafd8f900de483394087230f48
;;  (defun dm/change-commit-author (arg)
;;  "Change the commit author during an interactive rebase in Magit.
;;  With a prefix argument, insert a new change commit author command
;;  even when there is already another rebase command on the current
;;  line.  With empty input, remove the change commit author action
;;  on the current line, if any."
;;  (interactive "P")
;;  (let ((author
;;          (magit-transient-read-person "Select a new author for this commit"
;;                          nil
;;                          nil)))
;;  (git-rebase-set-noncommit-action
;;  "exec"
;;  (lambda (_) (if author
;;                  (format "git commit --amend --author='%s'" author)
;;                  ""))
;;  arg)))
;;
;;  (define-key git-rebase-mode-map (kbd "h") #'dm/change-commit-author)

;; https://github.com/Azkae/magit-prime
(use-package! magit-prime
  :config
  (magit-prime-mode))
