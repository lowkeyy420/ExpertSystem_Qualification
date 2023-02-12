(deftemplate video
	(slot name)
    (slot type)
    (slot rating)    
)

(deftemplate my-video
	(slot name)
    (slot type)
    (slot rating)    
)

(deftemplate recommended-video
	(slot name)
    (slot type)
    (slot rating)    
)

(deffacts initial-video
	(video (name "Miley Cyrus Jumping In The Pool") (type "Exclusive") (rating "4.9") )
    (video (name "Ariana Grande Special Dance") (type "Exclusive") (rating "4.7") )
    (video (name "Hannah Montana Old Footage") (type "Premium") (rating "4.1") )
    (video (name "XQC Final Goodbye ") (type "Premium") (rating "2.5") )
    (video (name "John Cheena Ice Cream Compilation") (type "Premium") (rating "4.3") )
    (video (name "Karen Being A Karen") (type "Premium") (rating "1.1") )
    (video (name "Johnny Bravo 2.0") (type "Premium") (rating "3.2") )
    (video (name "Riley R. Cute Announcement") (type "Exclusive") (rating "5") )    
)

(reset)

/* Rules
rating -> Low / High
type  -> Premium / Exclusive
rating -> Low -> Show all premium
rating -> High -> Type -> Premium -> show all Premium with rating > 4
rating -> High -> Type -> Exclusive -> show all Exclusive with rating > 4
*/

(defrule rating-low
    (r-low)
    (video (name ?name) (type ?type) (rating ?rating))
    (test (eq ?type "Premium"))
    =>
    (assert (recommended-video (name ?name) (type ?type)  (rating ?rating)))
    (run)
)

(defrule rating-high
    (r-high ?type_)
	(video (name ?name) (type ?type)  (rating ?rating))
    (test (and (eq ?type ?type_) (> ?rating 4)))
    =>
    (assert (recommended-video (name ?name) (type ?type)  (rating ?rating)))
    (run)
)

(defrule recommendation
    (start-recommendation ?rating ?type)
    =>
    (if (eq ?rating "Low")
    	then (assert (r-low))
     elif (eq ?rating "High")
    	then (assert (r-high ?type))
    )
    (run)
)

(defquery get-recommended-videos
    (recommended-video (name ?name) (type ?type)  (rating ?rating))
)

(defquery get-all-videos
    (video (name ?name) (type ?type) (rating ?rating))
)

(deffunction clrscr ()
	"Clearing Screen Utility"
	(for (bind ?i 0) (< ?i 32) (++ ?i)(printout t crlf))
)

(deffunction mainMenu ()
	"Main Menu"
    (clrscr)
	(printout t crlf "YOutube red")
    (printout t crlf "1. Upload Video")
	(printout t crlf "2. View My Videos")
	(printout t crlf"3. Update Video")
	(printout t crlf "4. Remove Video")
	(printout t crlf "5. Recommend Video")
	(printout t crlf "6. Exit")
	(printout t crlf ">> ")
)

(deffunction uploadVideo ()
	"Upload Video Menu"
    (clrscr)
    (bind ?name "")
    (while (< (str-length ?name) 10)
		(printout t crlf "Input Video Name [10 characters +] : ")
        (bind ?name (readline))
    )
 
    (bind ?type "")
     (while (and (neq (str-compare ?type "Premium") 0) (neq (str-compare ?type "Exclusive") 0))
	    (printout t crlf "Input Video Type [ "Premium" , "Exclusive" ] (Case Sensitive) : ")
        (bind ?type (readline))
    )
    
    (bind ?rating 99)
     (while (>= ?rating 5)
    	(printout t crlf "Input Video Rating (Max 5) : ")
        (bind ?rating (read))
    )
    
    (assert (video (name ?name) (type ?type) (rating ?rating)))
    (printout t crlf "Successfully added video...")
    (readline)
)

(deffunction viewVideos ()
	"View Available Videos"
	(new app.QueryVideos)
    (readline)
)

(deffunction updateVideo ()
	"Update Video Information"
	(facts)
    
    (bind ?id "")
    
    (printout t crlf "Update Video [Choose The Correct Video ID]")
    (printout t crlf ">> ")
    (bind ?id (read))
    
    
    (bind ?name "")
    (while (< (str-length ?name) 10)
		(printout t crlf "Input Video Name [10 characters +] : ")
        (bind ?name (readline))
    )
 
    (bind ?type "")
     (while (and (neq (str-compare ?type "Premium") 0) (neq (str-compare ?type "Exclusive") 0))
	    (printout t crlf "Input Video Type [ "Premium" , "Exclusive" ] (Case Sensitive) : ")
        (bind ?type (readline))
    )
    
    (bind ?rating 99)
     (while (>= ?rating 5)
    	(printout t crlf "Input Video Rating (Max 5) : ")
        (bind ?rating (read))
    )
    
    (modify ?id (name ?name) (type ?type) (rating ?rating))
    (facts)
    (readline)
)

(deffunction removeVideo ()
	"Remove Video"
    (facts)
    (bind ?id "")
    (printout t crlf "Remove Video [Choose The Correct Video ID]")
    (printout t crlf ">> ")
    (bind ?id (read))
	(retract ?id)
    (facts)
    (readline)
    
)

(deffunction recommendVideo ()
	"Recommend Video"
	(printout t crlf "What Kind Of Videos Do You Like ? :)")
    
    (bind ?rating "")
    (bind ?type "")
    
 	(while (and (neq (str-compare ?type "Premium") 0) (neq (str-compare ?type "Exclusive") 0))
	    (printout t crlf "Preferred Video Type [ "Premium" , "Exclusive" ] (Case Sensitive) : ")
        (bind ?type (readline))
 	)
    
    (if (= (str-compare ?type "Exclusive") 0) 
    	then (while (and (neq (str-compare ?rating "High") 0) (neq (str-compare ?rating "Low") 0))
	    	(printout t crlf "Preferred Video Rating [ "High" (4 - 5) , "Low" (1 - 3) ] (Case Sensitive) : ")
        	(bind ?rating (readline))
 		)
     else (bind ?rating "Low")
    )
        
    (assert (start-recommendation ?rating ?type))
    (run)
    
	(new app.Gui)
    (readline)
)


(bind ?input 0)

(while (neq ?input 6)
 	(mainMenu)
    (bind ?input (read))
    
    (if (= ?input 1)
    	then (uploadVideo)
     elif (= ?input 2)
    	then (facts) (viewVideos) 
     elif (= ?input 3)
    	then (updateVideo)
     elif (= ?input 4)
    	then (removeVideo)
     elif (= ?input 5)
    	then (recommendVideo)
     elif (= ?input 6)
    	then (printout t crlf "Thank You For Using This Application ^-^")
    )
)