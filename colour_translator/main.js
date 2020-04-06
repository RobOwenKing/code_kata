const box = document.getElementById('box')

const sliders = document.querySelectorAll('.sliders input')

const red = document.getElementById('red')
const green = document.getElementById('green')
const blue = document.getElementById('blue')

console.log(sliders);

const updateBoxRGB = () => {
  console.log("Test");
  box.style.backgroundColor = `rgb(${red.value}, ${green.value}, ${blue.value})`;
};

sliders.forEach((slider) => {
  slider.addEventListener('input', (event) => {
    updateBoxRGB();
    //console.log("Test");
    //console.log(event);
  });
});
