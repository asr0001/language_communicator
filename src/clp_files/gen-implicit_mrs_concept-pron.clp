;generates output file "mrs_info-pron.dat" which contains id, pron and pronoun_q for all the pronouns


(defglobal ?*mrsdef* = mrs-def-fp)
(defglobal ?*defdbug* = mrs-def-dbug)

;Rule for pronoun : if (id-pron ?id yes) generate (id-MRS_Rel ?id pronoun_q) and (id-MRS_Rel ?id pron)
(defrule mrsPron_yes
(id-pron  ?id  yes)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " pronoun_q )"crlf)
(printout ?*defdbug* "(rule-rel-values mrsPron_yes id-MRS_concept "?id " pronoun_q )"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " pron )"crlf)
(printout ?*defdbug* "(rule-rel-values mrsPron_yes id-MRS_concept "?id " pron )"crlf)
)

; Generates new facts (MRS_info id-MRS_concept ID pron) and (MRS_info id-MRS_concept ID _pronoun) for imperative sentences
; Ex. Sahara jAo
(defrule pron4imper
(sentence_type imperative)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept -10000 pronoun_q)"crlf) 
(printout ?*defdbug* "(rule-rel-values pron4imper id-MRS_concept -10000  pronoun_q )"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept -10000 pron )"crlf)
(printout ?*defdbug* "(rule-rel-values pron4imper id-MRS_concept -10000 pron )"crlf)
)

;rule for possesive pronoun :if ((rel_name-ids r6 ?id) is present, generate (id-MRS_concept ?id def_explicit_q) and (id-MRS_concept ?id poss)
(defrule mrs_poss_pron
(rel_name-ids viSeRya-r6 ?viSeRya ?r6)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?viSeRya " def_explicit_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_poss_pron id-MRS_concept "?viSeRya " def_explicit_q)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?viSeRya " poss)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_poss_pron id-MRS_concept "?viSeRya " poss)"crlf)
)