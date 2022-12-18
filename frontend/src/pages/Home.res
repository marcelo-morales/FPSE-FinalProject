open Utils
open Array

type coord = {x : int; y : int}

// const variable that will set the width and length of the canvas
type canvasProperties = {dimmension : int ref };;
let currentstate = {dimmension = ref 28};;

 type canvas // abstract type for a canvas object
  @send external getElementById: (canvas, string) => Dom.element = "getElementById"
  @val external doc: canvas = "document"

  let myCanvas = getElementById(doc, "canvas")

  // 2d array is initizlied withh all zeros
  let pixelsFirstInput = Array.make_matrix ~dimx: 28 ~dimy: 28 0
  let pixelsSecondInput = Array.make_matrix ~dimx: 28 ~dimy: 28 0 
  let operation = ""


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

//canvas
  
  let (elements, setElements) = React.useState(_ => [])
  let (isDrawing, setIsDrawing) = React.useState(_ => false)

  let (points, setPoints) = React.useState(_ => [])
  let (path, setPath) = React.useState(_ => [])

  let (action, setAction) = React.useState(_ => "none")
  let (setToolType, setToolType) = React.useState(_ => "pencil")
  let (selectedElement, setSelectedElement) = React.useState(_ => null)

  let createElement = (id: int, x1: int, y1: int, x2: int, y2: int) => {
    let rougEle = gen.line (x1, y1, x2, y2) in 
    {id, x1, y1, x2, y2, roughEle}
  }

  let midPointsBtw = (p1: pixel, p2: pixel) => {
   {
    x: p1.x + (p2.x - p1.x) / 2,
    y: p1.y + (p2.y - p1.y) / 2,
  };
};

  let adjustElementCoordinates =  (element) => {
     let { type, x1, y1, x2, y2 } = element;
  if (x1 < x2 || (x1 === x2 && y1 < y2)) {
     { x1, y1, x2, y2 };
  } else {
     { x1: x2, y1: y2, x2: x1, y2: y1 };
  }
}

  // Runs everytime `prop1` or `prop2` has changed
React.useEffect2(() => {
  // Run effects based on prop1 / prop2

  /*
var el = document.getElementById("myId");

type document // abstract type for a document object
@send external getElementById: (document, string) => Dom.element = "getElementById"
@val external doc: document = "document"

let el = getElementById(doc, "myId")
  */

  // type canvas // abstract type for a canvas object
  // @send external getElementById: (canvas, string) => Dom.element = "getElementById"
  // @val external doc: canvas = "document"

  // let myCanvas = getElementById(doc, "canvas")

  let context = myCanvas.getContext("2d");
  context.lineCap = "round";
  context.lineJoin = "round";

  context.save();

  let drawpath = () => {
      path.forEach((stroke, index) => {
        context.beginPath();

        stroke.forEach((point, i) => {
          let midPoint = midPointBtw(point.clientX, point.clientY);

          context.quadraticCurveTo(
            point.clientX,
            point.clientY,
            midPoint.x,
            midPoint.y
          );
          context.lineTo(point.clientX, point.clientY);
          context.stroke();
        });
        context.closePath();
        context.save();
      });
    };

    let roughCanvas = rough.canvas(canvas);

    if (path !== undefined) drawpath();

    elements.forEach(({ roughEle }) => {
      context.globalAlpha = "1";
      roughCanvas.draw(roughEle);
    });

    return () => {
      context.clearRect(0, 0, canvas.width, canvas.height);
    };
}, (prop1, prop2))

  let updateElement = (index: int, x1: int, y1: int, x2: int, y2: int, toolType: string) => {
    let updatedElement = createElement(index, x1, y1, x2, y2, toolType);
    let elementsCopy = [...elements];
    elementsCopy[index] = updatedElement;
    setElements(elementsCopy);
  };

  let handleMouseDown = (e) => {
    console.log(toolType);
    let { clientX, clientY } = e;
    let canvas = document.getElementById("canvas");
    let context = canvas.getContext("2d");

    let id = elements.length;
    if (toolType === "pencil") {
      setAction("sketching");
      setIsDrawing(true);

      let transparency = "1.0";
      let newEle = {
        clientX,
        clientY,
        transparency,
      };
      setPoints((state) => [...state, newEle]);

      context.lineCap = 5;
      context.moveTo(clientX, clientY);
      context.beginPath();
    } else {
      setAction("drawing");
      let element = createElement(id, clientX, clientY, clientX, clientY);

      setElements((prevState) => [...prevState, element]);
      setSelectedElement(element);
      console.log(elements);
    }
  };

    let handleMouseMove = (e) => {
    let canvas = document.getElementById("canvas");
    let context = canvas.getContext("2d");
    let { clientX, clientY } = e;

    if (action === "sketching") {
      if (!isDrawing) return;

      let transparency = points[points.length - 1].transparency;
      let newEle = { clientX, clientY, transparency };

      setPoints((state) => [...state, newEle]);
      let midPoint = midPointBtw(clientX, clientY);
      context.quadraticCurveTo(clientX, clientY, midPoint.x, midPoint.y);
      context.lineTo(clientX, clientY);
      context.stroke();
    } else if (action === "drawing") {
      let index = elements.length - 1;
      let { x1, y1 } = elements[index];

      updateElement(index, x1, y1, clientX, clientY, toolType);
    }
  };

  let handleMouseUp = () => {
    if (action === "drawing") {
      let index = selectedElement.id;
      let { id, type, strokeWidth } = elements[index];
      let { x1, y1, x2, y2 } = adjustElementCoordinates(elements[index]);
      updateElement(id, x1, y1, x2, y2, type, strokeWidth);
    } else if (action === "sketching") {
      let canvas = document.getElementById("canvas");
      let context = canvas.getContext("2d");
      context.closePath();
      let element = points;
      setPoints([]);
      setPath((prevState) => [...prevState, element]); //tuple
      setIsDrawing(false);
    }
    setAction("none");
  };

//canvas

/*
count non transparent pixels
*/

let pixelsNotFilledIn = () => {
    // get a reference to your canvas

  let ctx=myCanvas.getContext("2d");

  // get the pixel data from the canvas
  let imgData=ctx.getImageData(0,0,c.width,c.height);

  // loop through each pixel and count non-transparent pixels
  let count=0;
  
  let canvasLength = imgData.data.length

  for i = 1 to canvasLength do 
    if (imgData.data[i+3]==0) 
      { count++; 
    }
    i = i + 4
  done;

}


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
          // setHasError(_ => false)e
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
      ~bottom="5%",
      ~left="5%",
       ~borderRadius="5%",
       ~fontSize="200%",
       ~margin="5% 2.5%",
       ~padding="5% 5%",
       ~backgroundColor="lightblue",
      ())}
      
      > 
        {"+"->React.string} 
      </button>
      
      
      
      
      <button style=
      {ReactDOM.Style.make(~color="red",  
      ~bottom="5%",
      ~left="5%",
       ~borderRadius="5%",
       ~fontSize="200%",
       ~margin="5% 2.5%",
       ~padding="5% 5%",
       ~backgroundColor="lightblue",
      ())}>  {"x"->React.string} </button>

       </div>

        <div className="h-8 mt-2 px-6 w-full flex items-center">


      <button style=
      {ReactDOM.Style.make(~color="red",  
       ~bottom="5%",
      ~left="5%",
       ~borderRadius="5%",
       ~fontSize="200%",
       ~margin="5% 2.5%",
       ~padding="5% 5%",
       ~backgroundColor="lightblue",
      ())}> {"-"->React.string} </button>

      <button style=
      {ReactDOM.Style.make(~color="red",  
     ~bottom="5%",
      ~left="5%",
       ~borderRadius="5%",
       ~fontSize="200%",
       ~margin="5% 2.5%",
       ~padding="5% 5%",
       ~backgroundColor="lightblue",
      ())}> {"/"->React.string} </button>

         <button style=
      {ReactDOM.Style.make(~color="red",  
       ~bottom="2.5%",
      ~left="5%",
       ~borderRadius="5%",
       ~fontSize="200%",
       ~margin="5% 2.5%",
       ~padding="5% 5%",
       ~backgroundColor="pink",
       ~onClick={_evt => RescriptReactRouter.push("/result")}
      ())}> {"="->React.string} </button>

      <button style=
      {ReactDOM.Style.make(~color="red",  
     ~bottom="2.5%",
      ~left="5%",
       ~borderRadius="5%",
       ~fontSize="200%",
       ~margin="5% 2.5%",
       ~padding="5% 5%",
       ~backgroundColor="lightgreen",
      ())}> {"Erase"->React.string} </button>

              
    </div>

     <div>
      <div>
        <Swatch setToolType={setToolType} />
      </div>
      // make canvas a multiple of 28 by 28
      <canvas
        id="canvas"
        className="App"
        width={window.innerWidth}
        height={window.innerHeight}
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
      >
        Canvas
      </canvas>
    </div>



  
  </div>
}


