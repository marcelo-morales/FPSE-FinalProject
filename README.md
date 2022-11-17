# Numerade


Numerafe a web app that uses machine learning to recognize written numbers to compute an operation, similar to a calculator. For instance, the user will use their mouse to draw the number “2”, then press a button for “+” and then draw the number “2”, press “=”, and our web app will display  “4.” We will preliminarily support the four operations of addition, subtraction, multiplication, and division. In addition, our machine learning model will be very well trained to read in any kind of variation of a numerical number, using the [mnist](https://github.com/datapythonista/mnist) dataset.

GitHub Repo URL: https://github.com/marcelo-morales/FPSE-FinalProject 


## Installing / Getting started

To install all the dependencies, do:
```
opam install torch
opam install dream
opam install rescript
```

To run the MLtest, you have to be in the MLtest directory and do:

```
dune exec ./example.exe
```


## User Manual

Documentation for your users will navgiate the Numerade web app. 


## Design

Corresponding design and user interface wireframe sketching can be found in [this Figma] (https://www.figma.com/file/X1w7aaslzVlGoMeHAPfq6M/FPSE-Final-Project?node-id=0%3A1).


## API Reference

This is the documentation of our API. It includes both public and Admin only endpoints. For endpoints tagged with Admin, You must provide a valid admin authorization token.


### Get Homepage of Numerade Website

```mermaid
sequenceDiagram
    autonumber
    Frontend->>Dream Server: GET/
    Dream->>Frontend: response.json{resulting_number}
```


### Get calculation

```mermaid
sequenceDiagram
    autonumber
    Frontend->>Dream Server: GET/math?num_one={first_number}?op={operation}?num_two={second_number}
    Dream->>Frontend: response.json{resulting_number}
```


