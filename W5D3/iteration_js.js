const myFactors = (number) => {
  let factors = [];
  for (let i = 1; i <= number; i++) {
    if (number % i === 0) {
      factors.push(i);
    }
  }
  return factors;
};

myFactors(12); // => [1, 2, 3, 4, 6, 12]

const myBubbleSort = (array) => {
  let sorted = false;

  while (!sorted) {
    sorted = true;
    for(let i = 0; i < array.length - 1; i++) {
      let j = i + 1;
      if (array[i] > array[j]) {
        let first = array[j];
        array[j] = array[i];
        array[i] = first;
        sorted = false;
      }
    }
  }

  return array;
};

myBubbleSort([2, 3, 1, 6, 3, 743, 18, 2]); // => [1, 2, 2, 3, 3, 6, 18, 743]

const myBubbleSortCallback = (array, callback) => {
  let sorted = false;

  while (!sorted) {
    sorted = true;
    for(let i = 0; i < array.length - 1; i++) {
      let j = i + 1;
      if (callback(array[i], array[j])) {
        let first = array[j];
        array[j] = array[i];
        array[i] = first;
        sorted = false;
      }
    }
  }

  return array;
};

// Use "greater than" symbol for Ascending
myBubbleSortCallback([2, 3, 1, 6, 3, 743, 18, 2],
  (el1, el2) => { return el1 > el2; }); // => [1, 2, 2, 3, 3, 6, 18, 743]
// Use "less than" symbol for Decending
myBubbleSortCallback([2, 3, 1, 6, 3, 743, 18, 2],
  (el1, el2) => { return el1 < el2; }); // => [743, 18, 6, 3, 3, 2, 2, 1]

const mySubstrings = (string) => {
  let substrings = [];

  for(let i = 0; i < string.length; i++) {
    for(let j = i + 1; j <= string.length; j++) {
      //substring instead of slice!!
      //watch out!! if first argument greater than second, it will
      //flip it for you!!
      substrings.push(string.substring(i, j));
    }
  }

  return substrings;
};

mySubstrings("cat"); // => ["c", "ca", "cat", "a", "at", "t"]

const mySubstringsSlice = (string) => {
  let substrings = [];

  for(let i = 0; i < string.length; i++) {
    for(let j = i + 1; j <= string.length; j++) {
      //slice instead of substring!!
      //negatives will go from the end... (can't grab last character)
      substrings.push(string.slice(i, j));
    }
  }

  return substrings;
};

mySubstringsSlice("cat"); // => ["c", "ca", "cat", "a", "at", "t"]
