(lang dune 3.4)

  (generate_opam_files true)
  (authors "Marcelo Morales" "Christian Raasteen")
  (maintainers "marcelomv11@gmail.com")
  (package
   (name numerade) ; put in your own project name here
   (synopsis "An OCaml web app that uses machine learning to recognize written numbers to compute an operation, similar to a calculator")
   (description "Numerade is a web app that identifies written numbers (by a user's mouse) to compute an operationce. For instance, the user will use their mouse to draw the number “2”, then press a button for “+” and then draw the number “2”, press “=”, and our web app will display “4.” We will preliminarily support the four operations of addition, subtraction, multiplication, and division. In addition, our machine learning model will be very well trained to read in any kind of variation of a numerical number, using the mnist dataset.")
   (depends
    (ounit2 (> 2.0)) ; for each opam dependency list the version
    (core (> 0.14.1)) ; `opam list core` will display which version of core you have
    (torch (= 0.17)) ;
    (dream (= 1.0.0)) ;
    (lwt (= 5.6.1)) ;
 ))