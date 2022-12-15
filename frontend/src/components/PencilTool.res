@react.component
let make = () => {
    let (points, setPoints) = React.useState(_ => [])
    let (drawin, setDrawing) = React.useState(_ => false)

    // todo: define this as a record
    let (posX, setPosX) = React.useState(_ => 0)
    let (posY, setPosY) = React.useState(_ => 0)

    
     let startDrawing = _evt => {
     setDrawing(true);
    let { clientX, clientY } = _evt
   
    setPosX(clientX)
    //pos.x = clientX

    setPosY(clientY)
    //pos.y = clientY
  
  }

  let finishDrawing = _evt => {
    setDrawing(false);
  }

  let draw = _evt => {
    //  reverse if, throw exception
    if (drawing) {
        setPoints((state) => [...state, pos]);
        contextRef.current.moveTo(pos.x, pos.y);

        let { clientX, clientY } = event;
        pos.x = clientX;
        pos.y = clientY;
    }
  }

  let useLayoutEffect = _EVT => {

    // js.documentgetelementbyid -> lookup in rescript API
    let canvas = document.getElementById("canvas");
    let ctx = canvas.getContext("2d");

    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.lineCap = "round";
    ctx.strokeStyle = "black";
    ctx.lineWidth = 2;
    contextRef.current = ctx;

    // for everything in react -> there is corresponding rescript
    // lookup docs to update in useEffect in rescript

    // check if cell is painted on - Canvas API, check which part of the canvas is painted on
    points.forEach((ele) => {
      contextRef.current.lineTo(ele.x, ele.y);
      contextRef.current.stroke();
    }, [points]);

  }
    <div>
      <canvas
        id="canvas"
        width={window.innerWidth}
        height={window.innerWidth}
        onMouseDown={startDrawing}
        onMouseUp={finishDrawing}
        onMouseMove={draw}
      >
        Canvas
      </canvas>
    </div>
    
}



 




