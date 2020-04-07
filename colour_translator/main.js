// The sample colour region in the middle of the page
const box = document.getElementById('box');

// Get all our inputs via DOM
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

// Use RGB sliders' values to update colour sample region
const updateBoxColour = () => {
  box.style.backgroundColor = `rgb(${red.value}, ${green.value}, ${blue.value})`;
};

// Use RGB sliders' values to update hex code in text input
const updateHex = () => {
  // First calculate the individual components of the hex colour
  // Convert the red value from base 10 to hex (uppercase)
  let hexRed = parseInt(red.value).toString(16).toUpperCase();
  // We need to append 0 before a one digit value
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

  // Update the hex colour based on the values calculated
  hex.value = `#${hexRed}${hexGreen}${hexBlue}`;
};

// Use RGB sliders' values to update RGB code in text input
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
  let hValue;
  if (delta == 0) {
    hValue = 0;
  } else if (cMax === rPrime) {
    hValue = 60 * (((gPrime - bPrime) / delta) % 6);
    hValue = hValue < 0 ? 360 + hValue : hValue;
  } else if (cMax === gPrime) {
    hValue = 60 * (((bPrime - rPrime) / delta) + 2);
  } else if (cMax === bPrime) {
    hValue = 60 * (((rPrime - gPrime) / delta) + 4);
  } else {
    hValue = "Oops";
  }
  return hValue;
};

const updateHSL = () => {
  const rPrime = red.value/255;
  const gPrime = green.value/255;
  const bPrime = blue.value/255;
  const cMax = Math.max(rPrime, gPrime, bPrime);
  const cMin = Math.min(rPrime, gPrime, bPrime);
  const delta = cMax - cMin;

  const hValue = calculateH(rPrime, gPrime, bPrime, cMax, cMin, delta);
  const lRaw = (cMax + cMin) / 2;
  const lValue = lRaw * 100;
  const sRaw = calculateS(delta, lRaw);
  const sValue = sRaw * 100;

  hue.value = hValue;
  saturation.value = sValue;
  lightness.value = lValue;

  hsl.value = `hsl(${hue.value}, ${saturation.value}%, ${lightness.value}%)`;
};

slidersRGB.forEach((slider) => {
  slider.addEventListener('input', (event) => {
    updateBoxColour();
    updateHex();
    updateRGB();
    updateHSL();
    //console.log("Test");
    //console.log(event);
  });
});
