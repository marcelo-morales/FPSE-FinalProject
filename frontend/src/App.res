open Utils


@react.component
let make = () => {
  //let (list: array<transaction>, setList) = React.useState(_ => [])
  //let (mathR: wallet, setWallet) = React.useState(_ => {usd_bal: 0., btc_bal: 0., msg: ""})
  let (mathResult, setmathResult) = React.useState(_ => 1)
  let (hasError, setHasError) = React.useState(_ => false)

  React.useEffect2(() => {
    open Promise
    let _ =
      Result.get("http://localhost:8080/result")
      ->then(ret => {
        switch ret {
        | Ok(res) =>
          setHasError(_ => false)
          mathResult(_ => res)->resolve
        | Error(msg) =>
          setHasError(_ => true)
          reject(FailedRequest("Error: " ++ msg))
        }
      })
      ->catch(e => {
        switch e {
        | FailedRequest(msg) => Js.log("Operation failed! " ++ msg)
        | _ => Js.log("Unknown error")
        }
        resolve()
      })

    let _ =
      Result.get("http://localhost:8080/wallet")
      ->then(ret => {
        switch ret {
        | Ok(res) =>
          setHasError(_ => false)
          setWallet(_ => res)->resolve
        | Error(msg) =>
          setHasError(_ => true)
          reject(FailedRequest("Error: " ++ msg))
        }
      })
      ->catch(e => {
        switch e {
        | FailedRequest(msg) => Js.log("Operation failed! " ++ msg)
        | _ => Js.log("Unknown error")
        }
        resolve()
      })
    None
  }, ( hasError))

  let url = RescriptReactRouter.useUrl()

  <div className="w-screen h-screen flex flex-row justify-center">
    <div className="w-frame h-full bg-white">
      <Header />
      {switch url.path {
      | list{"result"} => <Result />
      | list{} => <Home  loading setLoading hasError setHasError />
      | _ => <NotFound />
      }}
    </div>
  </div>
}
