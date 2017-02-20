#|
CS 2800 Homework 6 - Spring 2017


This homework is to be done in a group of 2-3 students. 

If your group does not already exist:

 * One group member will create a group in BlackBoard
 
 * Other group members then join the group
 
 Submitting:
 
 * Homework is submitted by one group member. Therefore make sure the person
   submitting actually does so. In previous terms when everyone needed
   to submit we regularly had one person forget but the other submissions
   meant the team did not get a zero. Now if you forget, your team gets 0.
   - It wouldn't be a bad idea for group members to send confirmation 
     emails to each other to reduce anxiety.

 * Submit the homework file (this file) on Blackboard.  Do not rename 
   this file.  There will be a 10 point penalty for this.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm group membership with the BB groups.
   If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.


Names of ALL group members: Chris Kenyon, Izaak Branch

Note: There will be a 10 pt penalty if your names do not follow 
this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|# 

#|
  WARM UP: These should be REALLY easy
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; comb-len2: List x List -> Nat
;; (comb-len2 m n) returns the number of different
;; ways pairs of items from list m and n can be combined
;; For example (m1 n1) (m1 n2)....(m2 n1)(m2 n2)....
;; This function shouldn't require recursion.
(defunc comb-len2 (m n)
  :input-contract (and (listp m)(listp n))
  :output-contract (natp (comb-len2 m n))
   (* (len m) (len n)))

(defdata lor (listof rational))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; sum: lor -> rational
;; (sum rl) takes a list of rationals rl and
;; returns the sum of all the values in the list.
(defunc sum (rl)
  :input-contract (lorp rl)
  :output-contract (rationalp (sum rl))
  (if (endp rl)
     0
     (+ (first rl) (sum (rest rl)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; Calc-grade: lor x lor x lor -> rational
;; (calc-grade e q a) Takes three lists of rationals
;; representing exams (e), quizzes (q), and assignments (a)
;; Each mark in each list is its contribution to the final grade.
;; Thus an 80% on exam1 (worth 30%) would be (80/100)*30 or 24.
;; Quizzes are worth 1% each so a mark of 18/24 would be given as 3/4.
;; You simply need to sum the three lists.
(defunc calc-grade (e q a)
  :input-contract (and (lorp e)(lorp q)(lorp a))
  :output-contract (rationalp (calc-grade e q a))
  (+ (sum e) (+ (sum q)(sum a))))

(check= (calc-grade '(24 26) 
                    '(1 1 1 1 1 1 1/2 1/2 1/2 1/2 1/2 1/2 3/4 3/4 3/4 3/4 3/4 3/4 3/4 3/4)
                    '(2 2 2 1 1 1 3/2 3/2 3/2 3/2)) 
        (+ (+ 50 15) 15)) 

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EQUATIONAL REASONING: Bickering students
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

In various CS courses like CS 2800, you are asked to work in teams to complete
an assignment and many times this can lead to conflict about who is correct.
Well one of your CS 2800 undergrad TAs is working on her own upper year 
assignment and is sick and tired of hearing all the screaming and name calling 
coming from your group. She looks over your code (above) and your partner's
implementation of the functions (below) and gives you a set of conjectures.  
If you can prove the conjectures are valid then she guarantees your more 
efficient solutions are equivalent to your partner's slower solutions. 

Even if your partner doesn't believe these conjectures lead to showing 
equality overall, your TA promises you that when grading your assignment she will 
give you full points. However, if you can't prove it, then your partner will 
mock you until you have to leave the university in disgrace (no pressure).

This example may seem contrived and university specific but the need to 
prove or test two functions return equivalent results frequently occurred 
when I was a professional developer.  Two approaches may be proposed by
a development team, one complex but potentially error prone while the other
is easier to understand but slower (a classic example would be binary
vs. linear search but typical cases were normally more subtle).
Demonstrating the faster solution is equivalent can be very persuasive.
Similarly, regression testing should demonstrate a new and improved 
function implementation passes the same tests as before 
(https://en.wikipedia.org/wiki/Regression_testing).  Regression testing
is weak evidence of equality but when it really matters, people actually 
prove the two designs/implementations are functionally equivalent (using 
many of the approaches we are using in this class). For example, functional
equivalences are used to prove a chip set adheres to the same standard as 
the previous generation chip.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Equational Reasoning Rules:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Questions 1 to 6 ask for equational proofs about ACL2
programs. Below you are given a set of function definitions you can use. 
Note in many cases the name has been slightly changed so you can't simply
use a theorem from class (ex. app2 instead of app)
The definitional axioms and contract theorems for
these functions can be used in the proof. You can use ACL2s to check
the conjectures you are proving but you are not required to do
so. 

Here are some notes about equational proofs:

1. The context: Remember to use propositional logic to rewrite
the context so that it has as many hypotheses as possible.  See
the lecture notes for details. Label the facts in your
context with C1, C2, ... as in the lecture notes.

2. The derived context: Draw a dashed line (----) after the context 
and add anything interesting that can be derived from the context.  
Use the same labeling scheme as was used in the context. Each derived
fact needs a justification. Again, look at the lecture notes for
more information.

3. Use the proof format shown in class and in the lecture notes,
which requires that you justify each step.  Explicitly name each
axiom, theorem or lemma you use, although we are starting to "cut 
corners" with the if axiom and the instantiations we are using. You
can take any "shortcuts" discussed in class.

5. When using the definitional axiom of a function, the
justification should say "Def. <function-name>".  When using the
contract theorem of a function, the justification should say
"Contract <function-name>".

6. Arithmetic facts such as commutativity of addition can be
used. The name for such facts is "arithmetic".

7. You can refer to the axioms for cons, and consp as the "cons axioms", 
Axioms for first and rest can be referred to as "first-rest axioms".
The axioms for if are named "if axioms"

8. Any propositional reasoning used can be justified by "propositional
reasoning", "Prop logic", or "PL", except you should use "MP" 
to explicitly identify when you use modus ponens and MT for Modus Tollens.

9. For any given propositional expression, feel free to re-write it
in infix notation (ex a =>(B/\C)).

10. For this homework, you can only use theorems we explicitly
tell you you can use or we have covered in class / lab. 
You can, of course, use the definitional axiom and contract 
theorem for any function used or defined in this homework. You
may also use theorems you've proven earlier in the homework.
Here are the definitions used for the remainder of the questions.

;; listp is built in but for this assignment, assume it 
;; is defined this way
(defunc listp (l)
  :input-contract t
  :output-contract (booleanp (listp l))
  (if (consp l)
     (listp (rest l))
     (equal l nil)))
    
(defunc endp (l)
  :input-contract (listp l)
  :output-contract (booleanp (endp l))
  (if (consp l) nil t))
  
(defunc len2 (x)
  :input-contract (listp len2x)
  :output-contract (natp (len2 x))
  (if (endp x)
    0
    (+ 1 (len2 (rest x)))))

(defunc app2 (x y)
  :input-contract (and (listp x)(listp y))
  :output-contract (listp (app2 x y))
  (if (endp x)
    y
    (cons (first x)(app2 (rest x) y))))

(defunc in2 (a l)
  :input-contract (listp l)
  :output-contract (booleanp (in2 a l))
  (if (endp l)
    nil
    (or (equal a (first l)) (in2 a (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For each of the conjectures in questions 1-6:

- Perform conjecture contract checking, and add hypotheses if necessary
  (contract completion). This is to make all functions in the conjecture 
  pass all input contracts.
  
- Run some tests to make an educated guess as to whether the conjecture is
  true or false. In the latter case, give a counterexample to the
  conjecture, and show that it evaluates to false. Else, give a proof 
  using equational reasoning, following instructions 1 to 10 above.

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
1.  LIST PAIR COMBINATIONS

Your partner's implementation of comb-len is as follows:
(defunc comb-len (m n)
  :input-contract (and (listp m) (listp n))
  :output-contract (natp (comb-len m n))
  (if (endp m) 
      0
      (+ (len2 n) (comb-len (rest m) n))))

In homework 5 you've already proven the following conjecture.
(implies (and (listp n) (equal m nil))
         (equal (comb-len m n) 0))
         
You solution for (comb-len2 nil n) = 0 (or at least it should).

Great.  What about when list m isn't empty?
Prove the following conjecture is valid to show that your
solution for comb-len2 is equivalent to your partner's.

(implies (and (listp m)(listp n)(not (endp m))
              (implies (listp (rest m)) 
                       (equal (comb-len (rest m) n) 
                              (* (len2 (rest m))(len2 n)))))
         (equal (comb-len m n) (* (len2 m)(len2 n))))

Notice the nested implies? Refer to the course notes for how
to handle implications in your proof.

(A/\(B=>C))=>D

C1. (listp m)
C2. (listp n)
C3. (not (endp m))
C4: (listp (rest m)) => [(comb-len (rest m) n) = (len2 (rest m)) * (len2 n)]
C5: {(listp m) /\ (listp n) /\ (not (endp m)) /\ [(listp (rest m)) => (comb-len (rest m) n) = (len2 (rest m)) * (len2 n)]} => (comb-len m n) = (len2 m) * (len2 n)
------------------------
C6. (listp (rest m)) {C1, C3, def. listp}
C7. (comb-len (rest m) n) = (len2 (rest m)) * (len2 n) {C4, C6, MP}


(comb-len m n)
= {def comb-len, C3, if-axioms}
(+ (len2 n) (comb-len (rest m) n)))
= {C7}
(len2 n) + [(len2 (rest m)) * (len2 n)]
= {arithmetic}
[(len2 (rest m)) + 1] * (len2 n)
= {Def. len2|((x m)), C3}
(len2 m) * (len2 n)

QED
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
2. Your partner's implementation of calc-grade is the following:
(defunc calc-grade (e q a)
  :input-contract (and (lorp e)(lorp q)(lorp a))
  :output-contract (rationalp (calc-grade e q a))
  (sum (app2 (app2 e q) a)))
  
  Notice how slow this is? The lists are combined and then summed!
  
  You can prove your implementation (which should be faster) gives the
  exact same answer by proving the following:

(implies (and (lorp x) (lorp l))
         (and (implies (endp x)
                       (equal (sum (app2 x l)) (+ (sum x) (sum l))))
              (implies (and (rationalp a)
                            (equal (sum (app2 x l)) (+ (sum x) (sum l))))
                       (equal (sum (app2 (cons a x) l)) (+ (sum (cons a x)) (sum l))))))

For your conjecture contract checking, you can assume that a lor is a
list, that appending two lors results in a lor, and that consing a
rational onto a lor results in a lor.

Notice the structure of the propositional expression above?
Propositional logic rules can prove that:
A => ((B =>C) /\ (D=>C)) = ((A=>(B=>C)) /\ (A =>(D =>C))

Thus we can split our proof obligations into two parts.
1) Write each conjecture you need to prove. Use exportation to make
your proof easier.

conjecture 1:
(implies (and (lorp x) (lorp l))
         (implies (endp x)
                  (equal (sum (app2 x l)) (+ (sum x) (sum l))))
                  
BY EXPORTATION, this simplifies to:

(implies (and (lorp x) (lorp l) (endp x))
         (equal (sum (app2 x l)) (+ (sum x) (sum l))))
                  
conjecture 2:
(implies (and (lorp x) (lorp l) 
              (rationalp a)
              (equal (sum (app2 x l)) (+ (sum x) (sum l))))
         (equal (sum (app2 (cons a x) l)) (+ (sum (cons a x)) (sum l))))
         
Exportation is similarly used here to extract the (rationalp a) and (equal (sum ...) ...)
terms into the conditional included in the first implies


2) Prove conjecture 1

(lorp x) /\ (lorp l) /\ (endp x) => [(sum (app2 x l)) = (sum x) + (sum l)]

c1: (lorp x)
c2: (lorp l)
c3: (endp x)
-------------

(sum (app2 x l))
= {def. app2| ((y l)), c3, if-axioms}
(sum l) //I know that (endp x), so I know (sum x) = 0. (sum l) + 0 = (sum l) but how do I formalize that?
= {def. sum|((rl x)), c3, arithmetic (anything plus 0 is itself)}
(sum l) + (sum x)
QED

  
3) Prove conjecture 2 (the not endp case). When using the definition
of app2 and sum, show the substitutions you are using.

(lorp x) /\ (lorp l) /\ (rationalp a) /\ [(sum (app2 x l)) = (sum x) + (sum l)] => [(sum (app2 (cons a x) l)) = (sum (cons a x) + (sum l))]

c1: (lorp x)
c2: (lorp l)
c3: (rationalp a)
c4: (sum (app2 x l)) = (sum x) + (sum l)
----------------

(sum (app2 (cons a x) l))
= {def. app2|((
  
As we will see in class soon, the above conjecture, which is now a theorem,
and your proof in homework 5 gives rise (via what is known as "induction") 
to the following theorem:

Phi_sum_app: (implies (and (lorp l1) (lorp l2))
                           (equal (sum (app2 l1 l2)) (+ (sum l1) (sum l2))))

Thus your solution should be faster but equivalent to your partner's.
Gloat away.
                           
You can assume in later questions that Phi_sum_app has been proven.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
3. OK.  Your partner now thinks that you call calc-grade with the wrong
parameters and thus your answers are wrong. *sigh*. He or she has provided
a theorem for you to prove:

(implies (and (listp x)(listp l))
              (equal (sum (app2 x l))(sum (app2 l x))))

....make sure you do contract checking and contract completion and then
prove the conjecture is valid. If you use Phi_sum_app, given the substitution
you are using.

  ..................

|#

#|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
4. Take the following definitions for min and max given to you.
(defunc min (lr)
  :input-contract (and (lorp lr)(not (endp lr)))
  :output-contract (rationalp (min lr))
  (if (endp (rest lr))
     (first lr)
     (if (< (first lr)(min (rest lr)))
         (first lr)
         (min (rest lr)))))

 (defunc max (lr)
  :input-contract (and (lorp lr)(not (endp lr)))
  :output-contract (rationalp (max lr))
  (if (endp (rest lr))
     (first lr)
     (if (> (first lr)(max (rest lr)))
         (first lr)
         (max (rest lr)))))


a) Your partner wrote the following test? and is now screaming that ACL2s
is broken because their test is clearly correct.  Help prove their 
conjecture (in the test?) or provide a counterexample.

(test? (implies (and (lorp lr)(not (endp lr)))
                (posp (- (max lr)(min lr)))))
                
  ................


b) Prove the following conjecture
(implies (and (lorp lr)(not (endp lr))
              (rationalp m)(< m (min lr))
              (implies (and (lorp lr)(not (endp lr)))
                            (<= (min lr) (max lr))))
         (posp (- (max (cons m lr))(min (cons m lr)))))

  ......................

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5.  TICK TAC TOE
;; A symbol on a tick tac toe board is 'x 'o or '- (nothing marked)
;; A board forms a 3x3 grid of values labeled from left to right,
;; top to bottom. Players win by putting 3 Xs or 3 Os in a row
;; horizontally, vertically or diagonally.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
(defdata mark (enum '(x o -)))
(defdata board (list mark mark mark mark mark mark mark mark mark))

Your partner wrote the function hasWinner while you wrote hasWinner2.

(defunc hasWinner (m1 m2 m3)
  :input-contract (and (markp m1)(markp m2)(markp m3))
  :output-contract (booleanp (hasWinner m1 m2 m3))
  (if (or (equal m1 '-) (equal m2 '-) (equal m3 '-))
    nil
    (and (equal m1 m2)(equal m1 m3))))

(defunc hasWinner2 (m1 m2 m3)
  :input-contract (and (markp m1)(markp m2)(markp m3))
  :output-contract (booleanp (hasWinner2 m1 m2 m3))
  (or (and (equal m1 'x) (equal m2 'x) (equal m3 'x))
      (and (equal m1 'o) (equal m2 'o) (equal m3 'o))))

Convince your partner that your function is equivalent to theirs by proving
the following conjecture:
(implies (and (markp m1)(markp m2)(markp m3))
         (equal (hasWinner m1 m2 m3)(hasWinner2 m1 m2 m3))))

You may assume the following expression is a theorem:
Phi_markDef: (implies (markp m)(or (equal m 'x)(equal m 'o)(equal m '-))

Hint: Can you represent equality in another way to provide more context?
Rewrite the conjecture and then prove the various parts.

................

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Question 6
  
  Now let's look back at HW04.  Here is a (modified) version of get-vars
  and related functions and data definitions, all of which have been 
  admitted into ACL2s:

(defdata los (listof symbol))
(defdata UnaryOp '~)
(defdata BinOp (enum '(^ v => <> =)))
(defdata PropEx (oneof boolean 
                       symbol 
                       (list UnaryOp PropEx)
                       (list PropEx BinOp PropEx)))

(defunc no-dupesp (l)
  :input-contract (listp l)
  :output-contract (booleanp (no-dupesp l))
  (cond ((endp l)   t)
        ((in2 (first l) (rest l))  nil)
        (t      (no-dupesp (rest l)))))

(defunc merge (l1 l2)
  :input-contract (and (losp l1)(losp l2))
  :output-contract (losp (merge l1 l2))
  (cond ((endp l1)  l2)
        ((in2 (first l1) l2) (merge (rest l1) l2))
        (t                  (cons (first l1) (merge (rest l1) l2)))))

(defunc get-vars (px)
  :input-contract (PropExp px)
  :output-contract (losp (get-vars px))
  (cond ((booleanp px) nil)
        ((symbolp px) (list px))
        ((equal (len px) 2) (get-vars (second px)))
        (t   (merge (get-vars (third px))
                    (get-vars (first px))))))
                    
  Your partner thinks the new provided function is wrong and stupid and it
  won't find the correct variables. Either variables will be duplicated
  or some will be missed. Prove the following conjectures to ease your minds.
  
  For both questions, you can assume for the purpose of contract 
  checking that a los is a list, and consing a symbol to a los results
  in a los.
  
  a) Your partner says "get-vars now generates duplicate variables." 
  Prove the following conjecture is valid. Later in the term this can 
  be used to prove get-vars DOES NOT return duplicates:
  
(implies (and (losp l1)(losp l2))
         (implies (and (no-dupesp l1)(no-dupesp l2)
                       (or (endp l1)
                           (and (not (endp l1)) (in2 (first l1) l2)
                                (implies (and (losp (rest l1))(losp l2))
                                         (no-dupesp (merge (rest l1) l2))))
                           (and (not (endp l1))(not (in2 (first l1) l2))
                                (implies (and (losp (rest l1))(losp l2))
                                         (no-dupesp (merge (rest l1) l2))))))
                  (no-dupesp (merge l1 l2))))

 
  Think about breaking this conjecture into 3 cases.
  
  You may assume the following is a theorem:
  Phi_in_merge:   (implies (and (symbolp s)(losp l1)(losp l2)
                                (in2 s (merge l1 l2)))
                           (or (in2 s l1)(in2 s l2)))
                           
  You won't be able to use Phi_in_merge in this format, but what is
  it equivalent to?  What if you know something about (in2 s l1) and 
  (in2 s l2) ?
 
  
  ..................
  
  Simplification through propositional logic:
  A = (endp l1), B = (in2 (first l1) l2), C = (implies (and (losp (rest l1))(losp l2))
                                                       (no-dupesp (merge (rest l1) l2)))
  A \/ (~A /\ B /\ C) \/ (~A /\ ~B /\ C)
  A \/ ((~A /\ C) /\ (B \/ ~B))
  A \/ (~A /\ C)
  A \/ C
  Results in:
  
 (implies (and (losp l1)(losp l2))
         (implies (and (no-dupesp l1)(no-dupesp l2)
                       (or (endp l1)                 
                           (implies (and (losp (rest l1))(losp l2))
                                    (no-dupesp (merge (rest l1) l2))))))
                  (no-dupesp (merge l1 l2))))
  
                                  
  Part 1:
  C1. (losp l1)
  C2. (losp l2)
  C3. (no-dupesp l1)
  C4. (no-dupesp l2)
  C5. (endp l1)
  -------
  
  (no-dupesp (merge l1 l2))
  = {def. merge, C5}
  (no-dupesp l2)
  = {C4}
  t
  
  
  Part 2 (B):
  C1. (losp l1)
  C2. (losp l2)
  C3. (no-dupesp l1)
  C4. (no-dupesp l2)
  C5. (not (endp l1))
  C6. (in2 (first l1) l2)
  C7. ((losp (rest l1)) /\ (losp l2)) => (no-dupesp (merge (rest l1) l2))
  -------
  C8. (losp (rest l1)) {C1, C5}
  C9. (no-dupesp (merge (rest l1) l2)) {C8, C2, C7, MP}
  
  (no-dupesp (merge l1 l2))
  = {def. merge, C5, C6}
  (no-dupesp (merge (rest l1) l2))
  = {C9}
  t
  
  
  Part 3 (~B):
  C1. (losp l1)
  C2. (losp l2)
  C3. (no-dupesp l1)
  C4. (no-dupesp l2)
  C5. (not (endp l1))
  C6. (not (in2 (first l1) l2))
  C7. ((losp (rest l1)) /\ (losp l2)) => (no-dupesp (merge (rest l1) l2))
  -------
  C8. (losp (rest l1)) {C1, C5}
  C9. (no-dupesp (merge (rest l1) l2)) {C8, C2, C7, MP}
  
  C10. (no-dupesp (rest l1)) {def. no-dupesp, C8, C6, C5}
  C11. (not (in2 (first l)) (rest l)) {def. no-dupesp, C10, C5}
  C12. (not (in2 (first l1) (merge (rest l1) l2))) {phi_in_merge|((s (first l1))(l1 (rest l1))(l2 l2)), C11, C6, MT} 
    (note on this one so I remember... We take phi_in_merge and prove that (in2 s l1) and (in2 s l2) are both 
    false, then modus tollens that to say that (in2 s (merge l1 l2)) is also false, substituting as done above)
    TODO: do I need to add symbol check for contract checking?
  
  (no-dupesp (merge l1 l2))
  = {def. merge, C5, C6}
  (no-dupesp (cons (first l1) (merge (rest l1) l2)))
  = {def. no-dupesp|((l (cons (first l1) (merge (rest l1) l2)))), C5, def. cons, C11}
  (no-dupes (merge (rest l1) l2))
  = {C9}
  t
  
  Q.E.D.
  
  ................
 
   
  b) OK.  So you're pretty sure get-vars has no duplicate variables now
  but you turned off contract checking for get-vars.
  
  Prove the following conjecture:
  (implies (PropExp px) (losp (get-vars px)))
  
  You might want to break the proof into cases.
  
  Our definition of PropEx gives rise to theorem Phi_PX_def
  (implies (PropExp px) (or (booleanp px)
                            (and (symbolp px)(not (booleanp px)))
                            (and (listp px)(equal (len2 px) 2)(UnaryOpp (first px))
                                 (PropExp (second px)))
                            (and (listp px)(equal (len2 px) 3)(BinOpp (second px))
                                 (PropExp (first px)) (PropExp (third px)))))
  You can also assume the following are true:
  Phi_PX_2: (implies (and (listp px)(equal (len2 px) 2)(PropExp (second px)))
                     (losp (get-vars (second px)))))
  Phi_PX_1: (implies (and (listp px)(equal (len2 px) 3)(PropExp (first px)))
                     (losp (get-vars (first px))))
  Phi_PX_3: (implies (and (listp px)(equal (len2 px) 3)(PropExp (third px)))
                     (losp (get-vars (third px))))
                     
 ............
 
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Feedback (5 points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

Each week we will ask a couple questions to monitor how the course
is progressing.  This should be a far shorter questionnaire than 
for HW05. 

Please fill out the following form.

https://goo.gl/forms/NE8SJk3PO82Uy4l42

As before, feedback is anonymous and each team member should fill out
the form (only once per person).

After you fill out the form, write your name below in this file, not
on the questionnaire. We have no way of checking if you submitted the
file, but by writing your name below you are claiming that you did,
and we'll take your word for it.  

5 points will be awarded to each team member for filling out the 
questionnaire.

The following team members filled out the feedback survey provided by 
the link above:
---------------------------------------------
Chris Kenyon
Izaak Branch

|#