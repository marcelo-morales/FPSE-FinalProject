open Utils

@react.component
let make = (
  ~loading: bool,
  ~setLoading: (bool => bool) => unit,
  ~hasError: bool,
  ~setHasError: (bool => bool) => unit,
//    ~result: float,
//   ~setresult: (float => float) => unit,
    // ~input: float,
//   ~setInput: (float => float) => unit,
) => {
  let (mathResult) = React.useState(_ => 0.)

//   let handleInput = evt => {
//     let val = ReactEvent.Form.target(evt)["value"]
//     setInput(_ => val)
//   }
// POST request

  let handleMath = _evt => {
    open Promise
    let _ = {
      setLoading(_ => true)
      Result.get(j`http://localhost:8080/result`)
      ->then(ret => {
        switch ret {
        | Ok(_) =>
          setLoading(_ => false)
          setHasError(_ => false)
          resolve()
        | Error(msg) =>
          setLoading(_ => false)
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
    }
  }

    React.useEffect1(() => {
    handleMath()
    None
  }, [mathResult])
  

  <div className="bg-frame w-full h-content flex flex-col-reverse pb-2">
    <div className="h-8 mt-2 px-6 w-full flex items-center">
      {hasError
        ? <button
            className="w-full start-btn font-serif border-2 border-white rounded-md hover:drop-shadow-lg transition duration-150 ease-in"
            // onClick={handleStartGame}
            disabled={loading}>
            {React.string("Start")}
          </button>
        : <div className="w-full flex justify-between">
            <div className="flex items-center">
              <div
                className="h-6 rounded-lg bg-black text-white text-sm font-medium px-2 flex items-center mr-1.5">
                <div className="mr-0.5"> {React.string(Js.String.fromCodePoint(0x20bf))} </div>
                {React.float(2.0)}
              </div>
              <div
                className="h-6 rounded-lg bg-emerald-500 text-white text-sm font-medium px-2 flex items-center mr-1.5">
                // <Icons.DollarIcon className="w-4 h-4" /> {React.float(wallet.usd_bal)}
              </div>
            </div>
            <div className="flex gap-1.5">
              <input
                defaultValue={Belt.Float.toString(3.0)}
                // onChange={handleInput}
                className="w-14 text-sm border-2 border-white rounded-md outline-none text-center"
              />
              <button
                className="w-12 buy-btn border-2 border-white col-span-2 rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                // onClick={handleBuy}
                disabled={loading}
                title="Buy">
              </button>
              <button
                className="w-12 sell-btn border-2 border-white col-span-2 rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                disabled={loading}
                title="Sell">
              </button>
              <button
                className="w-6 border-2 border-white rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                onClick={_evt => RescriptReactRouter.push("/analytics")}
                disabled={loading}
                title="Analytics">
              </button>
              <button
                className="w-6 border-2 border-white rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                // onClick={handleStartGame}
                disabled={loading}
                title="Restart game">
              </button>
            </div>
          </div>}
    </div>
  
  </div>
}


