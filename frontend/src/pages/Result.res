open Utils
open Belt
open Types

@react.component
let make = (
  ~list: array<Types.transaction>,
  ~loading: bool,
  ~setLoading: (bool => bool) => unit,
  ~hasError: bool,
  ~setHasError: (bool => bool) => unit,
  ~wallet: Types.wallet,
) => {
  let (amount, setAmount) = React.useState(_ => 0.)
  let (typing, setTyping) = React.useState(_ => false)
  let (prediction, setPrediction) = React.useState(_ => {
    btc: 0.,
    real_usd_value: 0.,
    predicted_usd_value: 0.,
  })


}
