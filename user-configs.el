;; class title
;; syllabus
;; book
;; notes directory
;; website

(setq lectorg-notes-directory "~/Dropbox/notes/"


 lectorg-classes '((?e "Education Foundations")
						(?d "Data Structures")
						(?l "LitHum")
						)
      lectorg-classes-resources '(
                                  ("Education Foundations"
                                   ("https://docs.google.com/document/d/1W9Dcr-VwD_lQJWyypY4LwYOhxFUZgEfO5M7HqXEv0nI/" . link)
								   nil ;; no book
                                   ("~/Dropbox/notes/edfoundations/" . path)
								   ("https://courseworks2.columbia.edu/courses/171048" . link)
								   )
                                  ("Data Structures"
								   nil ;; no syllabus
                                   ("~/Dropbox/files/literature/Data Structures and Algorithm Analysis in Java (2012) Weiss.pdf" . pdf)
                                   nil
								   ("https://courseworks2.columbia.edu/courses/168168" . link))
                                  ("LitHum"
								   ("~/Dropbox/notes/syllabi/LitHum Syllabus Sem 2.pdf" . pdf)
								   nil
                                   nil
								   ("https://courseworks2.columbia.edu/courses/166360" . link))
								  ))
