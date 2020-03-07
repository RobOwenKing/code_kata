const sudokuArray = [];
let solutionArray = [];
const sudokuTable = document.querySelector('#sudoku tbody');
const solutionTable = document.querySelector('#solution tbody');

// Save the state of the grid in an array of arrays for ease of manipulation
const createSudokuArray = () => {
  for (let i = 0; i < 9; i += 1) {
    const latestRow = [];
    for (let j = 0; j < 9; j += 1) {
      latestRow.push(0);
    }
    sudokuArray.push(latestRow);
  }
};

// Populate the html table of inputs we'll use for the interface
const createSudokuTable = () => {
  for (let i = 0; i < 9; i += 1) {
    sudokuTable.insertAdjacentHTML('beforeend', '<tr></tr>');
    const latestRow = document.querySelector('#sudoku tbody > tr:last-child');
    for (let j = 0; j < 9; j += 1) {
      latestRow.insertAdjacentHTML('beforeend', '<td><input type="text" /></td>');
    }
  }
};

// Populate the html table we'll use to display the solution
const createSolutionTable = () => {
  for (let i = 0; i < 9; i += 1) {
    solutionTable.insertAdjacentHTML('beforeend', '<tr></tr>');
    const latestRow = document.querySelector('#solution tbody > tr:last-child');
    for (let j = 0; j < 9; j += 1) {
      latestRow.insertAdjacentHTML('beforeend', '<td></td>');
    }
  }
};

// Check whether a number already appears in a row
const validInRow = (num, row) => {
  if (solutionArray[row].some(entry => entry === num)) {
    return false;
  } else {
    return true;
  }
};

// Check whether a number already appears in a column
const validInCol = (num, col) => {
  if (solutionArray.some(entry => entry[col] === num)) {
    return false;
  } else {
    return true;
  }
};

// Check whether a number already appears in a block
const validInBlock = (num, x, y) => {
  let valid = true;
  const blockCol = Math.floor(x / 3);
  const blockRow = Math.floor(y / 3);
  for (let i = 0; i < 3; i += 1) {
    for (let j = 0; j < 3; j += 1) {
      if (solutionArray[(blockRow * 3) + i][(blockCol * 3) + j] === num) {
        valid = false;
      }
    }
  }
  return valid;
};

const checkValid = (num, x, y) => {
  if (validInRow(num, y) && validInCol(num, x) && validInBlock(num, x, y)) {
    return true;
  } else {
    return false;
  }
};

const updateCellInSolution = (x, y) => {
  // console.log(sudokuArray[y][x]);
  const cell = solutionTable.childNodes[y + 1].childNodes[x];
  if (solutionArray[y][x] >= 1 && solutionArray[y][x] <= 9) {
    cell.innerText = solutionArray[y][x];
  } else {
    cell.innerText = "";
  }
  // console.log(solutionTable.childNodes[y + 1].childNodes[x]);
};

const updateSolution = () => {
  for (let i = 0; i < 9; i += 1) {
    for (let j = 0; j < 9; j += 1) {
      updateCellInSolution(i, j);
    }
  }
};

const createTableListeners = () => {
  sudokuCells.forEach(cell => {
    cell.addEventListener('blur', (event) => {
      const y = cell.closest("tr").rowIndex;
      const x = cell.closest("td").cellIndex;
      const num = parseInt(cell.value, 10);
      digitRegex = /^[1-9]$/;
      if (digitRegex.test(cell.value)) {
        // checkValid(num, x, y);
        sudokuArray[y][x] = num;
      } else {
        sudokuArray[y][x] = 0;
      }
      updateCellInSolution(x, y);
    });
  });
};

createSudokuArray();
createSudokuTable();
createSolutionTable();

const sudokuCells = document.querySelectorAll('input');
createTableListeners();

// Algorithm to solve by brute force. As yucky a method as the code.
const solveBruteForce = () => {
  for (let i = 0; i < 9; i += 1) {
    for (let j = 0; j < 9; j += 1) {
      if (solutionArray[j][i] === 0) {
        for (let k = 1; k < 10; k += 1) {
          if (checkValid(k, i, j)) {
            solutionArray[j][i] = k;
            // updateCellInSolution(i, j);
            if (solveBruteForce()) {
              return true;
            }
            solutionArray[j][i] = 0;
            // updateCellInSolution(i, j);
          }
        }
        return false;
      }
    }
  }
  return true;
};

const btnBruteForce = document.getElementById('brute-force');
btnBruteForce.addEventListener('click', event => {
  console.log(sudokuArray);
  solutionArray = JSON.parse(JSON.stringify(sudokuArray));
  solveBruteForce();
  updateSolution();
  console.log(solutionArray);
  console.log(sudokuArray);
});

document.addEventListener('keyup', (event) => {
  const currentFocus = document.activeElement;
  // console.log(currentFocus.parentElement);
  // console.log(event.key == "ArrowRight");
  if (event.key === "ArrowRight") {
    const nextElement = currentFocus.parentElement.nextElementSibling;
    if (nextElement !== null) {
      nextElement.firstElementChild.focus();
    }
  } else if (event.key === "ArrowLeft") {
    const previousElement = currentFocus.parentElement.previousElementSibling;
    if (previousElement !== null) {
      previousElement.firstElementChild.focus();
    }
  } else if (event.key === "ArrowUp") {
    const child = currentFocus.parentElement;
    const parent = child.parentElement;
    const childPos = Array.prototype.indexOf.call(parent.childNodes, child);
    const newRow = parent.previousElementSibling;
    if (newRow !== null) {
      const target = newRow.childNodes[childPos].childNodes[0];
      target.focus();
    }
  } else if (event.key === "ArrowDown") {
    const child = currentFocus.parentElement;
    const parent = child.parentElement;
    const childPos = Array.prototype.indexOf.call(parent.childNodes, child);
    const newRow = parent.nextElementSibling;
    if (newRow !== null) {
      const target = newRow.childNodes[childPos].childNodes[0];
      target.focus();
    }
  }
});
