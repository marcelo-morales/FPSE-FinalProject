import React, { useState, useEffect } from "react";
import "./App.css";
import Swatch from "./components/swatch";
import rough from "roughjs/bundled/rough.esm";
import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';
import axios from 'axios';
import Typography from '@mui/material/Typography';

// import { Routes, Route } from "react-router-dom";


let buttonPressed = false;



const gen = rough.generator();
function createElement(id, x1, y1, x2, y2) {
  const roughEle = gen.line(x1, y1, x2, y2);
  return { id, x1, y1, x2, y2, roughEle };
}

const midPointBtw = (p1, p2) => {
  return {
    x: p1.x + (p2.x - p1.x) / 2,
    y: p1.y + (p2.y - p1.y) / 2,
  };
};

export const adjustElementCoordinates = (element) => {
  const { type, x1, y1, x2, y2 } = element;
  if (x1 < x2 || (x1 === x2 && y1 < y2)) {
    return { x1, y1, x2, y2 };
  } else {
    return { x1: x2, y1: y2, x2: x1, y2: y1 };
  }
};

function App() {
  const [elements, setElements] = useState([]);
  const [isDrawing, setIsDrawing] = useState(false);

  const [points, setPoints] = useState([]);
  const [path, setPath] = useState([]);

  const [action, setAction] = useState("none");
  const [toolType, setToolType] = useState("pencil");
  const [selectedElement, setSelectedElement] = useState(null);

  const [firstInput, setFirstInput] = useState([]);
  const [secondInput, setSecondInput] = useState([]);
  const [operation, setOperation] = useState("");

  const [result, setResult] = useState("");


  useEffect(() => {
    const canvas = document.getElementById("canvas");
    const context = canvas.getContext("2d");
    context.lineCap = "round";
    context.lineJoin = "round";

    context.save();

    const drawpath = () => {
      path.forEach((stroke, index) => {
        context.beginPath();

        stroke.forEach((point, i) => {
          var midPoint = midPointBtw(point.clientX, point.clientY);

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

    const roughCanvas = rough.canvas(canvas);

    if (path !== undefined) drawpath();

    elements.forEach(({ roughEle }) => {
      context.globalAlpha = "1";
      roughCanvas.draw(roughEle);
    });

    return () => {
      context.clearRect(0, 0, canvas.width, canvas.height);
    };
  }, [elements, path]);

  const updateElement = (index, x1, y1, x2, y2, toolType) => {
    const updatedElement = createElement(index, x1, y1, x2, y2, toolType);
    const elementsCopy = [...elements];
    elementsCopy[index] = updatedElement;
    setElements(elementsCopy);
  };

  const handleMouseDown = (e) => {
    console.log(toolType);
    const { clientX, clientY } = e;
    const canvas = document.getElementById("canvas");
    const context = canvas.getContext("2d");

    const id = elements.length;
    if (toolType === "pencil") {
      setAction("sketching");
      setIsDrawing(true);

      const transparency = "1.0";
      const newEle = {
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
      const element = createElement(id, clientX, clientY, clientX, clientY);

      setElements((prevState) => [...prevState, element]);
      setSelectedElement(element);
      console.log(elements);
    }
  };

  const handleMouseMove = (e) => {
    const canvas = document.getElementById("canvas");
    const context = canvas.getContext("2d");
    const { clientX, clientY } = e;

    if (action === "sketching") {
      if (!isDrawing) return;

      const transparency = points[points.length - 1].transparency;
      const newEle = { clientX, clientY, transparency };

      setPoints((state) => [...state, newEle]);
      var midPoint = midPointBtw(clientX, clientY);
      context.quadraticCurveTo(clientX, clientY, midPoint.x, midPoint.y);
      context.lineTo(clientX, clientY);
      context.stroke();
    } else if (action === "drawing") {
      const index = elements.length - 1;
      const { x1, y1 } = elements[index];

      updateElement(index, x1, y1, clientX, clientY, toolType);
    }
  };
  const handleMouseUp = () => {
    if (action === "drawing") {
      const index = selectedElement.id;
      const { id, type, strokeWidth } = elements[index];
      const { x1, y1, x2, y2 } = adjustElementCoordinates(elements[index]);
      updateElement(id, x1, y1, x2, y2, type, strokeWidth);
    } else if (action === "sketching") {
      const canvas = document.getElementById("canvas");
      const context = canvas.getContext("2d");
      context.closePath();
      const element = points;
      setPoints([]);
      setPath((prevState) => [...prevState, element]); //tuple
      setIsDrawing(false);
    }
    countNumPixels();
    setAction("none");
  };

  const countNumPixels  = () => {
    const canvas = document.getElementById("canvas");
   
    if (canvas) {
      const ctx = canvas.getContext("2d")
      let imageData = ctx.getImageData(0, 0, ctx.canvas.width, ctx.canvas.height);
      let dataArray = imageData.data;
      let finalDataArray = Array.from(dataArray);
      console.log("pencil up")
      console.log(finalDataArray.length);

      for (let i = 0; i < finalDataArray.length; ++i) {
        if (finalDataArray[i] !== 0) {
          finalDataArray[i] = 1;
        }
      }

      console.log(finalDataArray);

      if (!buttonPressed) {
        setFirstInput(finalDataArray)
      } else {
        setSecondInput(finalDataArray)
      }
  }

  }

  const startMathAdd = () => {
    setOperation("add")
    countNumPixels();
    buttonPressed= true;

    const canvas = document.getElementById("canvas");
    if (canvas) {
      const context = canvas.getContext('2d');
      context.clearRect(0, 0, 28*10, 28*10);
    }
  }

  const startMathSubtract = () => {
    setOperation("subtract")
    countNumPixels();
    buttonPressed= true;

    const canvas = document.getElementById("canvas");
    if (canvas) {
      const context = canvas.getContext('2d');
      context.clearRect(0, 0, 28*10, 28*10);
    }
  }

  const startMathMultiply = () => {
    setOperation("multiply")
    countNumPixels();
    buttonPressed= true;

    const canvas = document.getElementById("canvas");
    if (canvas) {
      const context = canvas.getContext('2d');
      context.clearRect(0, 0, 28*10, 28*10);
    }
  }

  const startMathDivide = () => {
    setOperation("divide")
    countNumPixels();
    buttonPressed= true;

    const canvas = document.getElementById("canvas");
    if (canvas) {
      const context = canvas.getContext('2d');
      context.clearRect(0, 0, 28*10,28*10);
    }
  }


  // end math
  const  endMath = async () => {

    console.log("this is first array")
    console.log(firstInput)
    console.log("this is second array")
    console.log(secondInput)
    console.log("this is operation")
    console.log(operation)

    countNumPixels();

    try {
      const response = await axios
      .get(
        `http://localhost:8080/result?num_one=${firstInput}&num_two=${secondInput}&op=${operation}`
      )

      const data = response.data;
      const mathResult = data.result;
      setResult(mathResult);
    } catch (err) {
      console.error(err);
    }
    

  }



  return (
    <div>
      
      <div>
        <Swatch setToolType={setToolType} />
      </div>
      <canvas
        id="canvas"
        className="App"
        width={28}
        height={28}
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
        // style={border: '1px solid #000'}
      >
        Canvas
      </canvas>

      <Stack spacing={2} direction="row">
        <Button variant="contained" onClick={() => startMathAdd()} >Addition</Button>
        <Button variant="contained" onclick={() => startMathSubtract()}>Subtraction</Button>
       </Stack>

       <Stack spacing={2} direction="row">
       <Button variant="contained" onclick={() => startMathMultiply()} >Multiplication</Button>
        <Button variant="contained" onclick={() => startMathDivide()} >Division</Button>
       </Stack>

       <Stack spacing={2} direction="row">

        <Button variant="contained" onClick={() => endMath()}>Equals</Button>
       </Stack>

       <Typography variant="h1" component="h2">
      The result is {result}
</Typography>;



       



      
    </div>
  );
}

export default App;
