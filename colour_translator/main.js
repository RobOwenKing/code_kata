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
const updateHexFromRGBSliders = () => {
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
const updateRGBFromRGBSliders = () => {
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

const updateHSLFromRGB = () => {
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

const calculateRGBPrimes = (cValue, xValue, hValue) => {
  if (hValue < 60) {
    return [cValue, xValue, 0];
  } else if (hValue < 120) {
    return [xValue, cValue, 0];
  } else if (hValue < 180) {
    return [0, cValue, xValue];
  } else if (hValue < 240) {
    return [0, xValue, cValue];
  } else if (hValue < 300) {
    return [xValue, 0, cValue];
  } else if (hValue < 360) {
    return [cValue, 0, xValue];
  }
};

const updateRGBFromHSLSliders = () => {
  const lValue = lightness.value / 100;
  const sValue = saturation.value / 100;

  const cValue = (1 - Math.abs(2 * lValue - 1)) * sValue;
  const xValue = cValue * (1 - Math.abs((hue.value / 60) % 2 - 1));
  const mValue = lValue - (cValue / 2);

  const RGBPrimes = calculateRGBPrimes(cValue, xValue, hue.value);

  red.value = (RGBPrimes[0] + mValue) * 255;
  green.value = (RGBPrimes[1] + mValue) * 255;
  blue.value = (RGBPrimes[2] + mValue) * 255;
};

const updateHSLfromHSLSliders = () => {
  hsl.value = `hsl(${hue.value}, ${saturation.value}%, ${lightness.value}%)`;
};

const updateSlidersBackground = () => {
  red.style.background = `linear-gradient(to right, rgb(0, ${green.value}, ${blue.value}), rgb(255, ${green.value}, ${blue.value}))`;
  green.style.background = `linear-gradient(to right, rgb(${red.value}, 0, ${blue.value}), rgb(${red.value}, 255, ${blue.value}))`;
  blue.style.background = `linear-gradient(to right, rgb(${red.value}, ${green.value}, 0), rgb(${red.value}, ${green.value}, 255))`;
  hue.style.background = `linear-gradient(to right, hsl(0, ${saturation.value}%, ${lightness.value}%),
    hsl(120, ${saturation.value}%, ${lightness.value}%),
    hsl(240, ${saturation.value}%, ${lightness.value}%),
    hsl(360, ${saturation.value}%, ${lightness.value}%))`;
  saturation.style.background = `linear-gradient(to right, hsl(${hue.value}, 0%, ${lightness.value}%),
    hsl(${hue.value}, 50%, ${lightness.value}%),
    hsl(${hue.value}, 100%, ${lightness.value}%))`;
  lightness.style.background = `linear-gradient(to right, hsl(${hue.value}, ${saturation.value}%, 0%),
    hsl(${hue.value}, ${saturation.value}%, 50%),
    hsl(${hue.value}, ${saturation.value}%, 100%))`;
};

slidersRGB.forEach((slider) => {
  slider.addEventListener('input', (event) => {
    updateBoxColour();
    updateHexFromRGBSliders();
    updateRGBFromRGBSliders();
    updateHSLFromRGB();
    updateSlidersBackground();
  });
});

slidersHSL.forEach((slider) => {
  slider.addEventListener('input', (event) => {
    updateRGBFromHSLSliders();
    updateBoxColour();
    updateHexFromRGBSliders();
    updateRGBFromRGBSliders();
    updateHSLfromHSLSliders();
    updateSlidersBackground();
  });
});

window.addEventListener('load', (event) => {
  updateBoxColour();
  updateHexFromRGBSliders();
  updateRGBFromRGBSliders();
  updateHSLFromRGB();
});
