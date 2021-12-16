;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; PLACEuuuu your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aleksandar Vucic"
      user-mail-address "vucinjo@gmail.com")

;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; TODO workaround for Monterey
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

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
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'atom-one-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/Org"
      org-annotate-file-storage-file "~/Dropbox/Org/annotated.org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

(setq auto-save-default t
      make-backup-files t)

;; (setq confirm-kill-emacs nil

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
;;
;; allow to jump to all windows
(setq avy-all-windows t)

(fringe-mode nil)

(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/dotfiles/emacs/snippets")))

(setq lsp-elixir-local-server-command "~/.eslint-ls/language_server.sh") ;

(setq +vc-gutter-default-style nil)

;; org
(with-eval-after-load  'org
  (require 'color)
  (set-face-attribute 'org-block nil :background
                      (color-darken-name
                       (face-attribute 'default :background) 3)))

;; (add-hook! 'org-mode-hook #'mixed-pitch-mode)
;; (add-hook! 'org-mode-hook #'solaire-mode)
;; (setq mixed-pitch-variable-pitch-cursor nil)
(setq org-outline-path-complete-in-steps nil
      org-refile-use-outline-path t
      org-directory "~/Dropbox/Org"
      org-default-notes-file "~/Dropbox/Org/notes.org"
      org-projectile-projects-file "~/Dropbox/Org/projects.org"
      org-reveal-root "file:///Users/vucinjo/Dropbox/Or/reveal.js"
      org-cycle-include-plain-lists 'integrate

      ;; org-edit-src-content-indentation 0
      ;; org-src-tab-acts-natively t
      ;; org-src-preserve-indentation nil

      org-refile-targets
      '(("projects.org" :maxlevel . 5)
        ("notes.org" :maxlevel . 1)
        ("index.org" :maxlevel . 3)
        ("tasks.org" :maxlevel . 1)
        ("notebook.org" :maxlevel . 5)
        ("access.org" :maxlevel . 1))

      org-todo-keywords
      '((sequence
         "IDEA(i)"
         "TODO(t)"
         "IN-PROGRESS(n)"
         "WAITING(w)"
         "BLOCKED(b)"
         "REVIEW(r)"
         "|"
         "FAIL(f)"
         "DONE(d)"
         "CANCELED(c)"))

      org-todo-keyword-faces
      '(
        ("IDEA" . "white")
        ("IN-PROGRESS" . "yellow")
        ("REVIEW" . "DarkOliveGreen3")
        ("WAITING" . "magenta")
        ("BLOCKED" . "DarkOrange")
        ("CANCELED" . "tomato3")
        ("FAIL" . "red")
        ("DONE" . "green3")
        )

      org-capture-templates
      '(
        ("b" "Notebook and Bookmarks")
        ("bc" "Category" entry (file "notebook.org")
         "* %? %^G" :prepend t)
        ("bn" "Note" entry (file "notebook.org")
         "* %? %^G \n%u" :prepend t)
        ("bl" "Link" entry (file "notebook.org")
         "* %A %^G \n%u" :prepend t)

        ("p" "Projects")
        ("pc" "Project name" entry (file "projects.org")
         "* %? %^G" :prepend t)
        ("pn" "Note" entry (file "projects.org")
         "* %? %^G \n%u" :prepend t)
        ("pl" "Link" entry (file "projects.org")
         "* %A %^G \n%u" :prepend t)

        ("t" "Tasks")
        ("tt" "Today Tasks" entry (file+headline "today.org" "Tasks")
         "* TODO %?\n%^T" :prepend t)
        ("tg" "Tasks" entry (file+headline "tasks.org" "Tasks")
         "* TODO %? %^G \n%u" :prepend t)

        ("n" "Notes")
        ("nc" "Category" entry (file "notes.org")
         "* %? %^G" :prepend t)
        ("nn" "Note" entry (file"notes.org")
         "* %? %^G \n%u" :prepend t)
        ("f" "Today Focus" entry (file+headline "today.org" "Today Focus")
         "* %? " :prepend t))
      )
;;  keybindings
;;  =======================================================================================================
(define-key evil-normal-state-map (kbd "H") 'beginning-of-line)
(define-key evil-normal-state-map (kbd "L") 'end-of-line)
(define-key evil-visual-state-map (kbd "H") 'beginning-of-line)
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


(map! :localleader
      :map robe-mode-map
      (:prefix ("s" . "Send to repl")
       :desc "ruby-send-line"
       "l" 'ruby-send-line
       "L" 'ruby-send-line-and-go
       "b" 'ruby-send-buffer
       "B" 'ruby-send-buffer-and-go))

(map! :localleader
      :map js-mode-map
      (:prefix ("s" . "Send to repl")
       :desc "ruby-send-line"
       "l" 'nodejs-repl-send-line
       "b" 'nodejs-repl-send-buffer
       "i" 'nodejs-repl-switch-to-repl))

(map!
 :leader
 :desc "Multiedit"
 "s e" #'evil-multiedit-match-all)

(map! :localleader
      :map python-mode-map
      (:prefix ("s" . "Send to repl")
       :desc "python-send-line"
       "r" 'python-shell-send-region
       "b" 'python-shell-send-buffer))



;; (map!
;;  :nv
;;  "C-n" #'evil-multiedit-match-and-next
;;  (:after evil-multiedit
;;   (:map evil-multiedit-state-map
;;    "C-n" #'evil-multiedit-match-and-next
;;    "C-p" #'evil-multiedit-match-and-prev
;;    "n" #'evil-multiedit-next
;;    "N" #'evil-multiedit-prev
;;    "p" #'evil-multiedit--paste-replace
;;    "gzz" #'+multiple-cursors/evil-mc-toggle-cursor-here
;;    )
;;   )
;;  )

;; hooks
;;  =======================================================================================================

(defun maybe-use-prettier ()
  "Enable prettier-js-mode if an rc file is located."
  (if (locate-dominating-file default-directory ".prettierrc")
      (prettier-js-mode +1)))

(add-hook 'typescript-mode-hook 'maybe-use-prettier)
(add-hook 'js2-mode-hook 'maybe-use-prettier)
(add-hook 'web-mode-hook 'maybe-use-prettier)
(add-hook 'rjsx-mode-hook 'maybe-use-prettier)
(add-hook 'prog-mode-hook 'lsp-ui-mode)
(add-hook 'ruby-mode-hook 'evil-ruby-text-objects-mode)

;; dired
(custom-set-faces!
  `(diredfl-file-name :foreground ,(doom-color 'blue))
  `(diredfl-number :inherit 'outline-8)
  `(diredfl-file-suffix :foreground ,(doom-color 'blue))
  ;; `(diredfl-flag-mark :foreground ,(doom-color 'blue))
  ;; `(diredfl-flag-mark-line :foreground ,(doom-color 'blue))
  `(diredfl-dir-heading :inherit 'outline-1)
  `(diredfl-dir-name :inherit 'outline-1)
  `(diredfl-dir-priv :inherit 'outline-1)
  `(diredfl-read-priv :background  nil)
  `(diredfl-write-priv :background nil :foreground "magenta")
  `(diredfl-exec-priv :background  nil)
  `(diredfl-deletion :background  nil)
  `(diff-hl-margin-change :background nil)
  `(diff-hl-margin-change :inherit 'epa-mark)
  `(all-the-icons-dired-dir-face :inherit 'outline-8)
  )

;; term
(custom-set-faces!
  `(term-color-yellow :foreground "#E5C07B")
  `(term-color-green :foreground "#98C379")
  `(term-color-red :foreground "#E06C75")
  )


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-4 ((t (:foreground "#98c379")))))


(use-package! google-translate
  :ensure t
  :config
  (defun google-translate--search-tkk ()
    "Search TKK."
    (list 430675 2721866130))
  (setq
   google-translate-default-source-language "en"
   google-translate-default-target-language "sr"))


;; (use-package! ox-awesomecv
;;     :load-path "org-cv/"
;;     :init (require 'ox-awesomecv))

;; (setq org-latex-pdf-process
;;       '("/Library/TeX/texbin/xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "/Library/TeX/texbin/xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "/Library/TeX/texbin/xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; (setq org-latex-compiler "/Library/TeX/texbin/xelatex")

;; custom functions
(defun gen-pass (input)
  "Generate my password"
  (interactive "sPass: ")
  (shell-command
   (concat "ruby ~/Documents/psd.rb " input " | pbcopy")))

(defun set-timer ()
  "Show a message after timer expires. Based on run-at-time and can understand time like it can."
  (interactive)
  (let* ((msg-to-show (read-string "Enter msg to show: "))
         (time-duration (read-string "Time? ")))
    (message time-duration)
    (run-at-time time-duration nil #'message-box msg-to-show)))

;; fetch url title for link desc in org-mode
(defun jmn/url-get-title (url &optional descr)
  "Takes a URL and returns the value of the <title> HTML tag,
   Thanks to https://frozenlock.org/tag/url-retrieve/ for documenting url-retrieve"
  (let ((buffer (url-retrieve-synchronously url))
        (title nil))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (search-forward-regexp "<title>\\([^<]+?\\)</title>")
      (setq title (match-string 1 ) )
      (kill-buffer (current-buffer)))
    title))

(setq org-make-link-description-function 'jmn/url-get-title)
