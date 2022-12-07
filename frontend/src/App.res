

@react.component
let make = () => {
  let (loading, setLoading) = React.useState(_ => false)
  let (hasError, setHasError) = React.useState(_ => false)

//   React.useEffect2(() => {
//     open Promise
 
//   }, (loading, hasError))

  let url = RescriptReactRouter.useUrl()

  <div className="w-screen h-screen flex flex-row justify-center">
    <div className="w-frame h-full bg-white">
      <Header />
      {switch url.path {
      | list{"result"} => <Result />
      | list{} => <Home loading setLoading hasError setHasError  />
      | _ => <NotFound />
      }}
    </div>
  </div>
}
