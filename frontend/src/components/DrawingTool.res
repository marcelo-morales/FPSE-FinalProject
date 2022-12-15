@react.component
let make = () => {

    let (elements, setElements) =  React.useState(_ => [])
    let (drawing, setDrawing)  = React.useState(_ => false)

    let createElement (x1 : int, y1: int, x2: int, y2: int) =
        let roughEle = gen.line(x1, y1, x2, y2)
        in  { x1, y1, x2, y2, roughEle };

    let useLayoutEffect = _evt => {
        let canvas = document.getElementById("canvas");
        let ctx = canvas.getContext("2d");

        //clearing the screen everytime it's re-rendered
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        let rc = rough.canvas(canvas);

        //performs a specified action for each element in the array
        elements.forEach((ele) => rc.draw(ele.roughEle));
  }
  //, [elements]);


  let startDrawing = _evt => {
        setDrawing(true);
        let { clientX, clientY } = event;
        let newEle = createElement(clientX, clientY, clientX, clientY);
        setElements((state) => [...state, newEle]); //copying to the previous state
  }

   let finishDrawing = _evt => {
        setDrawing(false);
  }

  let draw = _evt => {
    if (!drawing) return; //not in a mousedown postion

    let { clientX, clientY } = event;
    // console.log(clientX, clientY);
    const index = elements.length - 1; //last element of the array "elements"
    let { x1, y1 } = elements[index];
    let updatedEle = createElement(x1, y1, clientX, clientY);

    //update the position with the new element instead of the previous one

    let copyElement = [...elements];
    copyElement[index] = updatedEle; //replacing last index
    setElements(copyElement);
  }

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
    
    
    
}

