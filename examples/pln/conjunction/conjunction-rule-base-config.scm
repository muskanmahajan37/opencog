;;
;; URE Configuration file for a mere fuzzy conjunction rule
;;
;; Before running any PLN inference you must load that file in the
;; AtomSpace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load required modules and utils ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-modules (opencog))
(use-modules (opencog rule-engine))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define a rule-based system ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define conjunction-rule-base (ConceptNode "conjunction-rule-base"))
(InheritanceLink
   conjunction-rule-base
   (ConceptNode "URE")
)

;; Define conj-bc for convenience
(define (conj-bc target) (cog-bc target conjunction-rule-base (SetLink)))

;;;;;;;;;;;;;;;;
;; Load rules ;;
;;;;;;;;;;;;;;;;

;; Load the fuzzy conjunction rule
(add-to-load-path "../../../opencog/pln/rules/")
(load-from-path "fuzzy-conjunction-introduction-rule.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Associate rules to the conjunction rule base ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; List the rules and their weights.
(define rules
  (list
        (list fuzzy-conjunction-introduction-1ary-rule-name 1)
        (list fuzzy-conjunction-introduction-2ary-rule-name 1)
        (list fuzzy-conjunction-introduction-3ary-rule-name 1)
        (list fuzzy-conjunction-introduction-4ary-rule-name 1)
        (list fuzzy-conjunction-introduction-5ary-rule-name 1)
        )
  )

;; Associate rules to the conjunction rule base
(ure-add-rules conjunction-rule-base rules)

;;;;;;;;;;;;;;;;;;;;;;
;; Other parameters ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Termination criteria parameters. Two iterations are needed, one for
;; initializing the BIT, the other to calculate the conjunction.
(ure-set-num-parameter conjunction-rule-base "URE:maximum-iterations" 2)
