;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksandar Vucic"
      user-mail-address "vucinjo@gmail.com")

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
                                        ; (setq doom-font (font-spec :family "Source Code Pro" :size 14)
                                        ; doom-variable-pitch-font (font-spec :family "sans" :size 14))
(setq doom-font (font-spec :family "Source Code Pro" :size 14)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 13)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'atom-one-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/Org")

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
;; the highlighted symol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/dotfiles/emacs/snippets")))

(setq lsp-elixir-local-server-command "~/.eslint-ls/language_server.sh")
;;  keybindings
;;  =======================================================================================================
(define-key evil-normal-state-map (kbd "H") 'move-beginning-of-line)
(define-key evil-normal-state-map (kbd "L") 'end-of-line)
(define-key evil-visual-state-map (kbd "H") 'move-beginning-of-line)
(define-key evil-visual-state-map (kbd "L") 'end-of-line)

(map!
 :desc "Inc number"
 "C-a" #'evil-numbers/inc-at-pt-incremental)

(map!
 :desc "Dec number"
 "C-S-a" #'evil-numbers/dec-at-pt-incremental)

(map!
 :leader
 :desc "ace-select-window"
 "w W" #'ace-select-window)

(map!
 :leader
 :desc "ace-select-window"
 "w D" #'ace-delete-window)

(map!
 :leader
 :desc "Multiedit"
 "s e" #'evil-multiedit-match-all)

;; multiedit
(map!
 :nv
 "C-n" #'evil-multiedit-match-and-next
 (:after evil-multiedit
  (:map evil-multiedit-state-map
   "C-n" #'evil-multiedit-match-and-next
   "C-p" #'evil-multiedit-match-and-prev
   "n" #'evil-multiedit-next
   "p" #'evil-multiedit-prev
   )
  )
 )

;; hooks
;;  =======================================================================================================
;; Prevents some cases of Emacs flickering
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; lsp
;; (add-hook 'ruby-mode-hook #'lsp-ui-mode)
;; (add-hook 'js2-mode-hook #'lsp-ui-mode)
;; (add-hook 'elixir-mode-hook #'lsp-ui-mode)
;; (after! lsp-ui-mode
;;   (setq lsp-ui-doc-enable t))

(defun maybe-use-prettier ()
  "Enable prettier-js-mode if an rc file is located."
  (if (locate-dominating-file default-directory ".prettierrc")
      (prettier-js-mode +1)))

(add-hook 'typescript-mode-hook 'maybe-use-prettier)
(add-hook 'js2-mode-hook 'maybe-use-prettier)
(add-hook 'web-mode-hook 'maybe-use-prettier)
(add-hook 'rjsx-mode-hook 'maybe-use-prettier)

;; (after! html-mode-hook
;;   (lsp)
;;   (lsp-ui-mode))
