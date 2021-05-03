(defun bb/setup-term-mode ()

  (evil-local-set-key 'insert (kbd "C-e") 'bb/send-C-e)
  (evil-local-set-key 'insert (kbd "C-c") 'bb/send-C-c)
  (evil-local-set-key 'insert (kbd "C-k") 'bb/send-C-k)
  (evil-local-set-key 'insert (kbd "C-u") 'bb/send-C-u)
  (evil-local-set-key 'insert (kbd "C-p") 'bb/send-C-p)
  (evil-local-set-key 'insert (kbd "C-n") 'bb/send-C-n)
  )

(defun bb/send-C-e ()
  (interactive)
  (term-send-raw-string "\C-e"))

(defun bb/send-C-r ()
  (interactive)
  (term-send-raw-string "\C-r"))

(defun bb/send-C-c ()
  (interactive)
  (term-send-raw-string "\C-c"))

(defun bb/send-C-u ()
  (interactive)
  (term-send-raw-string "\C-u"))

(defun bb/send-C-k ()
  (interactive)
  (term-send-raw-string "\C-k"))

(defun bb/send-C-p ()
  (interactive)
  (term-send-raw-string "\C-p"))

(defun bb/send-C-n ()
  (interactive)
  (term-send-raw-string "\C-n"))

(defun gen-pass (input)
  "Nonce function"
  (interactive "sPass: ")
  (shell-command
   (concatenate 'string "ruby ~/Documents/psd.rb " input " | pbcopy"))
    )

(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "c" 'ediff-copy-both-to-C))

(defun codefalling//reset-eslint-rc ()
  (let ((rc-path (if (projectile-project-p)
                     (concat (projectile-project-root) ".eslintrc.js"))))
    (if (file-exists-p rc-path)
        (progn
          (message rc-path)
          (setq flycheck-eslintrc rc-path)))))

(defun evil-ex-search-next-auto-clear-highlight ()
  (interactive)
  (evil-ex-search-next)
  (run-with-idle-timer
   1 nil '(lambda () (spacemacs/evil-search-clear-highlight))))

(defun evil-ex-search-previous-auto-clear-highlights ()
  (interactive)
  (evil-ex-search-previous)
  (run-with-idle-timer
   1 nil '(lambda () (spacemacs/evil-search-clear-highlight))))

(defun kill-non-active-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer 
        (delq (current-buffer) 
              (remove-if-not 'buffer-file-name (buffer-list)))))

(defun kill-matching-buffers (regexp &optional internal-too no-ask)
  "Kill buffers whose name matches the specified REGEXP.
Ignores buffers whose name starts with a space, unless optional
prefix argument INTERNAL-TOO is non-nil.  Asks before killing
each buffer, unless NO-ASK is non-nil."
  (interactive "sKill buffers matching this regular expression: \nP")
  (dolist (buffer (buffer-list))
    (let ((name (buffer-name buffer)))
      (when (and name (not (string-equal name ""))
                 (or internal-too (/= (aref name 0) ?\s))
                 (string-match regexp name))
        (funcall (if no-ask 'kill-buffer 'kill-buffer-ask) buffer)))))

;; ;; ============================= sqls ===========================================
;; Variables related to sql configs
(setq lsp-sqls-connections nil)
(setq sql-connection-alist nil)

;;;###autoload
(defun format-postgres-sqls (host port user password db sslmode)
  (format "host=%s port=%s user=%s password=%s dbname=%s sslmode=%s"
          host port user password db sslmode))

;;;###autoload
(defun format-mysql-sqls (host port user password db)
  (format "%s:%s@tcp(%s:%s)/%s" user password host port db))

;;;###autoload
(defun format-postgres-uri (host port user password db)
  (format "postgresql://%s:%s@%s:%s/%s" user password host port db))


;;;###autoload
(defun add-to-sqls-connections (db-type data-src-name)
  (add-to-list 'lsp-sqls-connections
               (list (cons 'driver db-type)
                     (cons 'dataSourceName data-src-name))))

;;;###autoload
(defmacro add-to-sql-conection-alist (db-type name host port user password db)
  `(add-to-list 'sql-connection-alist
                (list (quote ,name)
                     (list 'sql-product (quote ,db-type))
                     (list 'sql-user ,user)
                     (list 'sql-server ,host)
                     (list 'sql-port ,port)
                     (list 'sql-password ,password)
                     (list 'sql-database ,db))))

;;;###autoload
(defmacro sql-add-postgres-db (name &rest db-info)
  "Adds a mysql database to emacs and lsp
   This macro expects a name to the database and a p-list of parameters
   :port, :user, :password, :database, :host
   The only optional is :port, its default value is 5432
   e.g.:
   (sql-add-postgres-db
        my-db-name ;; notice that there are no quotes here
        :port 1234
        :user \"username\"
        :host \"my-host\"
        :database \"my-db\"
        :password \"mypassword\")"
  `(let ((port (or ,(plist-get db-info :port) 5432))
         (user ,(plist-get db-info :user))
         (password ,(plist-get db-info :password))
         (host ,(plist-get db-info :host))
         (db ,(plist-get db-info :database)))
     (let ((full-uri (format-postgres-uri host port user password db))
           (data-src-name (format-postgres-sqls host port user password db "disable")))
       (add-to-sqls-connections "postgresql" data-src-name)
       (add-to-sql-conection-alist 'postgres ,name host port user password full-uri))))

;;;###autoload
(defmacro sql-add-mysql-db (name &rest db-info)
  "Adds a mysql database to emacs and lsp
   This macro expects a name to the database and a p-list of parameters
   :port, :user, :password, :database, :host
   The only optional is :port, its default value is 3306
   e.g.:
   (sql-add-mysql-db
        my-db-name ;; notice that there are no quotes here
        :port 1234
        :user \"username\"
        :host \"my-host\"
        :database \"my-db\"
        :password \"mypassword\")"
  `(let ((port (or ,(plist-get db-info :port) 3306))
         (user ,(plist-get db-info :user))
         (password ,(plist-get db-info :password))
         (host ,(plist-get db-info :host))
         (db ,(plist-get db-info :database)))

     (add-to-sqls-connections "mysql" (format-mysql-sqls host port user password db))
     (add-to-sql-conection-alist 'mysql ,name host port user password db)))
