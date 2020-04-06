const box = document.getElementById('box');

const sliders = document.querySelectorAll('.sliders input');

const red = document.getElementById('red');
const green = document.getElementById('green');
const blue = document.getElementById('blue');

const hex = document.getElementById('hex');
const rgb = document.getElementById('rgb');
const hsl = document.getElementById('hsl');


console.log(sliders);

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

sliders.forEach((slider) => {
  slider.addEventListener('input', (event) => {
    updateBoxRGB();
    updateHex();
    updateRGB();
    //console.log("Test");
    //console.log(event);
  });
});
