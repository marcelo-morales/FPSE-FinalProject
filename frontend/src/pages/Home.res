open Belt

@react.component
let make = (
  ~loading: bool,
  ~setLoading: (bool => bool) => unit,
  ~hasError: bool,
  ~setHasError: (bool => bool) => unit,
   ~result: float,
  ~setresult: (float => float) => unit,
    ~input: float,
  ~setInput: (float => float) => unit,
) => {
  let (mathResult, setmathResult) = React.useState(_ => 0.)

  let handleInput = evt => {
    let val = ReactEvent.Form.target(evt)["value"]
    setInput(_ => val)
  }

//   let handleMath = _evt => {
//     open Promise
//     let _ = {
//       setLoading(_ => true)
//       Result.get(j`http://localhost:8080/result?nums=${456}&ops=${plusminus}`)
//       ->then(ret => {
//         switch ret {
//         | Ok(_) =>
//           setLoading(_ => false)
//           setHasError(_ => false)
//           resolve()
//         | Error(msg) =>
//           setLoading(_ => false)
//           reject(FailedRequest("Error: " ++ msg))
//         }
//       })
//       ->catch(e => {
//         switch e {
//         | FailedRequest(msg) => Js.log("Operation failed! " ++ msg)
//         | _ => Js.log("Unknown error")
//         }
//         resolve()
//       })
//     }
  }

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
                {React.float(2.0l)}
              </div>
            //   <div
            //     className="h-6 rounded-lg bg-emerald-500 text-white text-sm font-medium px-2 flex items-center mr-1.5">
            //     <Icons.DollarIcon className="w-4 h-4" /> {React.float(wallet.usd_bal)}
            //   </div>
            </div>
            <div className="flex gap-1.5">
              <input
                defaultValue={Belt.Float.toString(amount)}
                onChange={handleInput}
                onFocus={_evt => setTyping(_ => true)}
                onBlur={_evt => setTyping(_ => false)}
                className="w-14 text-sm border-2 border-white rounded-md outline-none text-center"
              />
              <button
                className="w-12 buy-btn border-2 border-white col-span-2 rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                onClick={handleBuy}
                disabled={loading}
                title="Buy">
                <Icons.BuyIcon className="w-4 h-4" />
              </button>
              <button
                className="w-12 sell-btn border-2 border-white col-span-2 rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                onClick={handleSell}
                disabled={loading}
                title="Sell">
                <Icons.SellIcon className="w-4 h-4" />
              </button>
              <button
                className="w-6 border-2 border-white rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                onClick={_evt => RescriptReactRouter.push("/analytics")}
                disabled={loading}
                title="Analytics">
                <Icons.ChartIcon className="w-4 h-4" />
              </button>
              <button
                className="w-6 border-2 border-white rounded-md hover:drop-shadow-lg transition duration-150 ease-in flex flex-row justify-center items-center"
                onClick={handleStartGame}
                disabled={loading}
                title="Restart game">
                <Icons.RestartIcon className="w-4 h-4" />
              </button>
            </div>
          </div>}
    </div>
    {hasError
      ? <Error />
      : <>
          {typing
            ? <div className="px-6 pt-2 w-full">
                <div
                  className="w-full bg-gray-200 rounded-2xl h-[40px] border-2 border-white border-dashed flex items-center justify-between px-4 italic text-gray-500 text-sm">
                  <div>
                    {React.string(
                      `${prediction.btc->Float.toString}${Js.String.fromCodePoint(
                          0x20bf,
                        )} forecasted = \\$${prediction.predicted_usd_value->Float.toString}, real-time = \\$${prediction.real_usd_value->Float.toString}`,
                    )}
                  </div>
                  <div>
                    {React.string(
                      Js.String.fromCodePoint(0x00b1) ++
                      "$" ++
                      prediction.real_usd_value->Float.toString,
                    )}
                  </div>
                </div>
              </div>
            : <div />}
          <Transactions list />
        </>}
  </div>

