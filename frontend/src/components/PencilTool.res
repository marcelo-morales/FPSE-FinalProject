@react.component
let make = () => {
    let (points, setPoints) = React.useState(_ => [])
    let (drawin, setDrawing) = React.useState(_ => false)
    
     let startDrawing = _evt => {
     setDrawing(true);
    let { clientX, clientY } = _evt;
    pos.x = clientX;
    pos.y = clientY;
  
  }

  let finishDrawing = _evt => {
    setDrawing(false);
  }

  let draw = _evt => {
     if (!drawing) return;

    setPoints((state) => [...state, pos]);
    contextRef.current.moveTo(pos.x, pos.y);

    let { clientX, clientY } = event;
    pos.x = clientX;
    pos.y = clientY;
  }

  let useLayoutEffect = _EVT => {
    let canvas = document.getElementById("canvas");
    let ctx = canvas.getContext("2d");

    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.lineCap = "round";
    ctx.strokeStyle = "black";
    ctx.lineWidth = 2;
    contextRef.current = ctx;

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



 




