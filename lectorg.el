;; lectorg-jake
;; inspired by/heavily rewritten from https://gitlab.com/velocitatem/lectorg
;; (c) jakebox <jakebox0@protonmail.com>
;; WIP


;; Variables ---------------------

(defcustom lectorg-notes-directory "~/Documents/notes/"
  "Main notes directory")

(defcustom lectorg-classes '((?e "Class 1 title")
							 (?b "Class 2 title"))
  "List of classes with corresponding character shortcuts.")

(defcustom lectorg-classes-resources '(("Class 1 title"
										("Syllabus" . link)
										("Book" . pdf)
										("Notes directory" . path)
										("Website" . link))
									   ("Class 2 title"
										("Syllabus" . pdf)
										("Book" . pdf)
										("Notes directory" . path)
										("Website" . link)))
  "")


;; Selector functions -------------

(defun lectorg--select-class ()
  (-elem-index (read-multiple-choice "Select class: " lectorg-classes) lectorg-classes))

(defun lectorg--select-resource ()
  (car (read-multiple-choice "Open:"
							 '((?s "syllabus")
							   (?b "book")
							   (?n "notes")
							   (?w "website")))))

(defun lectorg-open-syllabus-item-mac (syllabus-item)
  (shell-command (concat "open " (shell-quote-argument
								  (expand-file-name (car syllabus-item))))))

;; User-facing functions ----------

(defun lectorg-class-hub ()
  (interactive)

  (let ((class-index (lectorg--select-class))
		(recs        lectorg-classes-resources)
        (resource    (lectorg--select-resource)))

    (cond
     ((eq resource ?s) ;; syllabus
	  (let ((syllabus-item (cadr (nth class-index recs))))
		(if (eq (cdr syllabus-item) 'link)
			(browse-url-chrome (car syllabus-item)) ;; if link
		  (lectorg-open-syllabus-item-mac syllabus-item))))

     ((eq resource ?b) ;; book
	  (let ((syllabus-item (nth 2 (nth class-index recs))))
		(lectorg-open-syllabus-item-mac syllabus-item)))

     ((eq resource ?n) ;; notes
	  (counsel-find-file nil (car (nth 3 (nth class-index recs)))))

     ((eq resource ?w) ;; website
      (browse-url-chrome (car (nth 4 (nth class-index recs)))))

	 ))
  )

(defun lectorg-write-notes-file ()
  (interactive)
  (let* ((class (lectorg--select-class))
		 (class-notes-dir (car (nth 3 (nth class lectorg-classes-resources))))
		 (date (org-read-date))
		 (source (read-string "Source: "))
		 (title  (replace-regexp-in-string " " "_" (read-string "Rest: ")))
		 (filename (concat
					class-notes-dir date
					;; if source is empty don't add a -
					(if (not (string-empty-p source)) "-")
					source "-" title ".org")))
	(write-file filename)))


(defun lectorg-open-a-note ()
  (interactive)
  (counsel-file-jump nil lectorg-notes-directory))
