;generates output file "mrs_info.dat" that contains id and MRS concept for a and the.
;udef_q for plural noun and mass noun.
;neg for negation.

(defglobal ?*mrsdef* = mrs-def-fp)
(defglobal ?*defdbug* = mrs-def-dbug)

;Rules for common noun with the as a determiner : if (id-def ? yes), generate (id-MRS_Rel ?id _the_q)
(defrule mrsDef_yes
(id-def  ?id  yes)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "(+ ?id 10) " _the_q )"crlf)
(printout ?*defdbug* "(rule-rel-values mrsDef_yes implicit_mrs_concept id-MRS_concept "?id " _the_q )"crlf)
)

;Rule for a as a determiner : if the is not present,is not a mass noun and not plural then generate (id-MRS_Rel ?id _a_q)
(defrule mrsDef_not
(id-gen-num-pers ?id ?g ?n ?p)
(not (id-def ?id yes))
(not (id-mass ?id yes))
(test (neq ?n  pl))
(not(id-pron ?id yes))
(not(id-propn ?id yes))
(not (rel_name-ids viSeRya-saMKyA_viSeRaNa ?id $?v))
(not (rel_name-ids viSeRya-r6 ?id ?r6))  ;mEM_kA_xoswa_bagIcA_meM_Kela_rahA_hE My friend is playing in the garden.
(not (id-concept_label	?id	kOna_1)) ;Who won the match?
(not (id-concept_label	?id	Gara_1))
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "(+ ?id 10) " _a_q)"crlf)
(printout ?*defdbug* "(rule-rel-values  mrsDef_not implicit_mrs_concept id-MRS_concept "?id " _a_q)"crlf)
)

;Rule for plural noun : if (?n is pl) generate ((id-MRS_Rel ?id _udef_q)
(defrule mrs_pl_notDef
(id-gen-num-pers ?id ?g ?n ?p)
(not (id-def ?id yes))
(not (id-mass ?id yes))
(test (eq ?n pl))
(not(id-pron ?id yes))
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "(+ ?id 10) " udef_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_pl_notDef implicit_mrs_concept id-MRS_concept "?id " udef_q)"crlf)
)

;Rule for mass noun : if (id-mass ?id yes) , generate (id-MRS_Rel ?id _udef_q)
(defrule mrs_mass_notDef
(id-gen-num-pers ?id ?g ?n ?p)
(id-mass ?id yes)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "(+ ?id 10)" udef_q)"crlf)
(printout ?*defdbug* "(rule-rel-values  mrs_mass_notDef implicit_mrs_concept id-MRS_concept "?id " udef_q)"crlf)
)

;Rule for negation : if (kriya-NEG ?id1 ?id2) is present, generate (id-MRS_Rel ?id _udef_q)
(defrule mrs_neg_notDef
(kriyA-NEG  ?kid ?negid)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?negid " neg)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_neg_notDef implicit_mrs_concept id-MRS_concept "?negid " neg)"crlf)
)

;Rule for proper noun: if ((id-propn ?id yes) is present, generate (id-MRS_concept ?id proper_q) and  (id-MRS_concept ?id named)
(defrule mrs_propn
(id-propn  ?id yes)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " proper_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_propn  id-MRS_concept "?id " proper_q)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " named)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_propn  id-MRS_concept "?id " named)"crlf)
)


;rule for interrogative sentences for 'what',
;generates (id-MRS_concept "?id " thing)
;	   (id-MRS_concept "?id " which_q)
(defrule mrs_inter_what
(id-concept_label ?id kyA_1)
(sentence_type  question)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " thing)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_what  id-MRS_concept "?id " thing)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " which_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_what  id-MRS_concept "?id " which_q)"crlf)
)

;rule for interrogative sentences for 'where',
;generates (id-MRS_concept "?id " place)
;          (id-MRS_concept "?id " which_q)
(defrule mrs_inter_where
(id-concept_label ?id kahAz_1)
(sentence_type  question)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " place_n)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_what  id-MRS_concept "?id " place_n"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " which_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_what  id-MRS_concept "?id " which_q)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " loc_nonsp)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_what  id-MRS_concept "?id " loc_nonsp)"crlf)

)

;written by sakshi yadav (NIT-Raipur)
;date-27.05.19
;rule for sentence -consists of word 'home'
; example -i am coming home
;generates (id-MRS_concept "?id " place_n)
;          (id-MRS_concept "?id " def_implicit_q)
;          (id-MRS_concept "?id " loc_nonsp)
(defrule mrs_home
(id-concept_label ?id Gara_1)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " place_n)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_home  id-MRS_concept "?id " place_n)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " def_implicit_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_home  id-MRS_concept "?id " def_implicit_q)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " loc_nonsp)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_home  id-MRS_concept "?id " loc_nonsp)"crlf)
)

; written by sakshi yadav (NIT-Raipur)
; date-27.05.19
;rule for sentence -consists of words 'yesterday','today','tomorrow' 
;example -i came yesterday
;generates (id-MRS_concept "?id " time_n)
;          (id-MRS_concept "?id " def_implicit_q)
;          (id-MRS_concept "?id " loc_nonsp)
(defrule mrs_kala
(id-concept_label ?id kala_1|kala_2|Aja_1)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " time_n)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_kala  id-MRS_concept "?id " time_n)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " def_implicit_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_kala  id-MRS_concept "?id " def_implicit_q)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " loc_nonsp)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_kala  id-MRS_concept "?id " loc_nonsp)"crlf)
)

;written by sakshi yadav(NIT Raipur) Date-7.06.19
;Generates new facts for days of weeks then generate (MRS_info id-MRS_concept ?id _on_p_temp) and (MRS_info id-MRS_concept ?id dofw) and  (MRS_info id-MRS_concept ?id proper_q) 
(defrule daysofweeks
(id-concept_label ?id somavAra|maMgalavAra|buXavAra|guruvAra|SukravAra|SanivAra|ravivAra)
=>
;(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " dofw)"crlf)
;(printout ?*defdbug* "(rule-rel-values  daysofweeks id-MRS_concept "?id " dofw)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " proper_q)"crlf)
(printout ?*defdbug* "(rule-rel-values  daysofweeks id-MRS_concept "?id " proper_q)"crlf)
)


;written by sakshi yadav(NIT Raipur) Date-11.06.19
;Generates new facts for months of years then generate (MRS_info id-MRS_concept ?id _on_p_temp) and (MRS_info id-MRS_concept ?id mofy) and  (MRS_info id-MRS_concept ?id proper_q) 
(defrule monthsofyears
(id-concept_label ?id janavarI|ParavarI|mArca|aprELa|maI|jUna|juLAI|agaswa|siwaMbara|aktUbara|navaMbara|xisaMbara)
=>
;(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " mofy)"crlf)
;(printout ?*defdbug* "(rule-rel-values  monthsofyears id-MRS_concept "?id " mofy)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " proper_q)"crlf)
(printout ?*defdbug* "(rule-rel-values  monthsofyears id-MRS_concept "?id " proper_q)"crlf)
)

;written by sakshi yadav(NIT Raipur) Date-11.06.19
;Generates new facts for years of centuries then generate (MRS_info id-MRS_concept ?id _in_p_temp) and  (MRS_info id-MRS_concept ?id proper_q) 
(defrule yearsofcenturies
(id-concept_label ?id ?num)
(rel_name-ids kriyA-k7t ?kri  ?id&:(numberp ?id))
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " proper_q)"crlf)
(printout ?*defdbug* "(rule-rel-values  yearsofcenturies id-MRS_concept "?id " proper_q)"crlf)
)



(defrule mrs_parg_d
(sentence_type  pass-assertive)
(kriyA-TAM ?kri ?tam)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?kri " parg_d)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_parg_d  id-MRS_concept "?kri" parg_d)"crlf)
)



;rule for interrogative sentences for 'who'
(defrule mrs_inter_who
(id-concept_label ?id kOna_1)
(sentence_type  question)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " which_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_who  id-MRS_concept "?id " which_q)"crlf)
)

;rule for interrogative sentences for 'when'
(defrule mrs_inter_when
(id-concept_label ?id kaba_1)
(sentence_type  question)
=>
(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " which_q)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_who  id-MRS_concept "?id " which_q)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " time_n)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_who  id-MRS_concept "?id " time_n)"crlf)

(printout ?*mrsdef* "(MRS_info id-MRS_concept "?id " loc_nonsp)"crlf)
(printout ?*defdbug* "(rule-rel-values mrs_inter_what  id-MRS_concept "?id " loc_nonsp)"crlf)
)