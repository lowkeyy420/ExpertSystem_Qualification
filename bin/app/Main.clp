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
	(video (name "Miley Cyrus Jumping In The Pool") (type "Premium") (rating "4.9") )
    (video (name "Ariana Grande Special Dance") (type "Exclusive") (rating "4.7") )
    (video (name "Hannah Montana Old Footage") (type "Exclusive") (rating "4.1") )
    (video (name "XQC Final Goodbye ") (type "Premium") (rating "2.5") )
    (video (name "John Cheena Ice Cream Compilation") (type "Premium") (rating "3.3") )
    (video (name "Karen Being A Karen") (type "Exclusive") (rating "1.1") )
    (video (name "Johnny Bravo 2.0") (type "Exclusive") (rating "2") )
    (video (name "Riley R. Cute Announcement") (type "Exclusive") (rating "5") )    
)

(reset)

; rulenya
	;rating -> low / high
	;type  -> Premium / Exclusive
	;rating -> low -> show all Premium
	;rating -> high -> type -> Premium -> show all Premium
	;rating -> high -> type -> Exclusive -> show all Exclusive

(defrule rating-low
    (b-low)
    (video (name ?name) (type ?type) (rating ?rating))
    (test (eq ?type "Premium"))
    =>
    (assert (recommended-video (name ?name) (type ?type)  (rating ?rating)))
    ;(assert (show-Premium-recommendation))
    ;(run)
)

(defrule rating-high
    (b-high ?type_)
	(video (name ?name) (type ?type)  (rating ?rating))
    (test (eq ?type ?type_))
    =>
    (assert (recommended-video (name ?name) (type ?type)  (rating ?rating)))
)

(defrule recommendation
    (start-recommendation ?rating ?type)
    =>
    (if (eq ?rating "low")
    	then (assert (b-low))
     elif (eq ?rating "high")
    	then (assert (b-high ?type))
    )
    (run)
)



(printout t "Input budget [ 'low' | 'high' ] (case sensitive)>>")
(bind ?rating (readline))
(printout t "input type ( Premium / Exclusive )>> ")
(bind ?type (readline))
(assert (start-recommendation ?rating ?type))

(run)
(facts)

(defquery get-recommended-video
    (recommended-video (name ?name) (type ?type)  (rating ?rating))
)

(defquery get-all-videos
    (video (name ?name) (type ?type)  (rating ?rating))
)


(new app.QueryVideos)