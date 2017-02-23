const myUniq = (array) => {
  let result = [];
  array.forEach(function (el) {
    if (!result.includes(el)) {
      result.push(el);
    }
  });
  return result;
};

myUniq([1, 2, 1, 3, 3]); // => [1, 2, 3]

const myTwoSum = (array) => {
  let result = [];
  for(let i = 0; i < array.length - 1; i++) {
    for(let j = i + 1; j < array.length; j++) {
      if(array[i] + array[j] === 0) {
        result.push([i, j]);
      }
    }
  }

  return result;
};

myTwoSum([-1, 0, 2, -2, 1]); // => [[0, 4], [2, 3]]

const myTranspose = (array) => {
  let result = [];

  for(let i = 0; i < array.length; i++) {
    let runningTotal = [];
    for(let j = 0; j < array.length; j++) {
      runningTotal.push(array[j][i]);
    }
    result.push(runningTotal);
  }

  return result;
};

myTranspose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]]);
    /* =>
    [[0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]];
*/
