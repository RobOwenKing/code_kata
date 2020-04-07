const box = document.getElementById('box');

const slidersRGB = document.querySelectorAll('.rgb input');
const red = document.getElementById('red');
const green = document.getElementById('green');
const blue = document.getElementById('blue');

const hex = document.getElementById('hex');
const rgb = document.getElementById('rgb');
const hsl = document.getElementById('hsl');

const slidersHSL = document.querySelectorAll('.hsl input');
const hue = document.getElementById('hue');
const saturation = document.getElementById('saturation');
const lightness = document.getElementById('lightness');

console.log(slidersHSL);
console.log(saturation);

const updateBoxRGB = () => {
  box.style.backgroundColor = `rgb(${red.value}, ${green.value}, ${blue.value})`;
};

const updateHex = () => {
  let hexRed = parseInt(red.value).toString(16).toUpperCase();
  if (hexRed.length === 1) {
    hexRed = "0" + hexRed;
  }
  let hexGreen = parseInt(green.value).toString(16).toUpperCase();
  if (hexGreen.length === 1) {
    hexGreen = "0" + hexGreen;
  }
  let hexBlue = parseInt(blue.value).toString(16).toUpperCase();
  if (hexBlue.length === 1) {
    hexBlue = "0" + hexBlue;
  }

  hex.value = `#${hexRed}${hexGreen}${hexBlue}`;
};

const updateRGB = () => {
  rgb.value = `rgb(${red.value}, ${green.value}, ${blue.value})`;
};

const calculateS = (delta, lValue) => {
  if (delta === 0) {
    return 0;
  } else {
    return delta / (1 - Math.abs(2 * lValue - 1));
  }
};

const calculateH = (rPrime, gPrime, bPrime, cMax, cMin, delta) => {

};

const updateHSL = () => {
  const rPrime = red.value/255;
  const gPrime = green.value/255;
  const bPrime = blue.value/255;
  const cMax = Math.max(rPrime, gPrime, bPrime);
  const cMin = Math.min(rPrime, gPrime, bPrime);
  const delta = cMax - cMin;

  // const hValue = calculateH(rPrime, gPrime, bPrime, cMax, cMin, delta);
  const lValue = (cMax + cMin) / 2;
  const sValue = calculateS(delta, lValue);
  console.log(lValue);
};

slidersRGB.forEach((slider) => {
  slider.addEventListener('input', (event) => {
    updateBoxRGB();
    updateHex();
    updateRGB();
    updateHSL();
    //console.log("Test");
    //console.log(event);
  });
});
