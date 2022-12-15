@react.component
let make = () => {
  <div className="w-full h-14 flex flex-row justify-between p-4 border-b">
  
    <h2 
    style=
      {ReactDOM.Style.make(
      ~padding= "1%",
  ~color= "white",
  ~alignItems="center",
  ~justifyContent="center",
  ~fontSize="large",
  ~fontWeight="large",
      ())}
    
    > 
    
    
    {React.string("Numerade")} </h2>
   
  </div>
}
