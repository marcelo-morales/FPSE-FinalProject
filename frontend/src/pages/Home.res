open Utils

@react.component
let make = (
  // ~loading: bool,
  // ~setLoading: (bool => bool) => unit,
  // // ~hasError: bool,
  // ~setHasError: (bool => bool) => unit,
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
      // setLoading(_ => true)
      Result.get(j`http://localhost:8080/result`)
      ->then(ret => {
        switch ret {
        | Ok(_) =>
          // setLoading(_ => false)
          // setHasError(_ => false)
          resolve()
        | Error(msg) =>
          // setLoading(_ => false)
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

      <button style=
      {ReactDOM.Style.make(~color="red",  
       ~position="absolute",
      ~bottom="0",
       ~borderRadius="20px",
       ~fontSize="120px",
       ~margin="500px 550px",
       ~padding="10px 60px",
       ~backgroundColor="lightblue",
      ())}
      
      > 
        {"+"->React.string} 
      </button>
      
      
      
      
      <button style=
      {ReactDOM.Style.make(~color="red",  
      ~position="absolute",
      ~bottom="0",
      ~marginLeft="40px",
      ~marginRight="40px",
       ~borderRadius="20px",
       ~fontSize="120px",
       ~margin="500px 550px",
       ~padding="10px 60px",
       ~backgroundColor="lightblue",
      ())}>  {"x"->React.string} </button>

       </div>

        <div className="h-8 mt-2 px-6 w-full flex items-center">


      <button style=
      {ReactDOM.Style.make(~color="red",  
       ~position="absolute",
      ~bottom="0",
       ~borderRadius="20px",
       ~fontSize="120px",
       ~margin="200px 50px",
       ~padding="10px 60px",
       ~backgroundColor="lightblue",
      ())}> {"-"->React.string} </button>

      <button style=
      {ReactDOM.Style.make(~color="red",  
       ~position="absolute",
      ~bottom="0",
       ~borderRadius="20px",
       ~fontSize="120px",
       ~margin="200px 550px",
       ~padding="10px 60px",
       ~backgroundColor="lightblue",
      ())}> {"/"->React.string} </button>

              
    </div>

   <div className="h-8 mt-2 px-6 w-full flex items-center">

       <button style=
      {ReactDOM.Style.make(~color="red",  
       ~position="absolute",
      ~bottom="0",
       ~right="100",
       ~borderRadius="20px",
       ~fontSize="120px",
       ~margin="300px 800px",
       ~padding="10px 60px",
       ~backgroundColor="pink",
      ())} > {"="->React.string} </button>
    

        
    </div>
  
  </div>
}


