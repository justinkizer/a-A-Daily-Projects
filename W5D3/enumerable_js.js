const myEach = (array, callback) => {
  for(let i = 0; i < array.length; i++) {
    callback(array[i]);
  }
  return array;
};

myEach([1, 2, 3], (el) => { console.log(el); });
myEach([4, 5, 6], function(el) { console.log(el); });

const myMap = (array, callback) => {
  let result = [];

  myEach(array, function (el) {
    result.push(callback(el));
  });

  return result;
};

myMap([1,2,3,4,5], function(el) { return el * 2; });

const myInject = (array, callback) => {
  let accumulator = array[0];
  myEach(array.slice(1,array.length), function (el) {
    accumulator = callback(accumulator, el);
  });

  return accumulator;
};

myInject([1,2,3,4,5], function(el1, el2) { return el1 * el2; });
myInject([10,60,300,55,5], function(el1, el2) { return el1 + el2; });

const mySelect = (array, callback) => {
  let result = [];

  myEach(array, function (el) {
    if (callback(el)) {
      result.push(el);
    }
  });

  return result;
};

mySelect([1,2,3,4,15], function(el) { return (el % 3); });
mySelect([1,2,3,4,15], function(el) { return (el % 3 === 0 ); });

const myInclude = (array, value) => {
  let result = false;

  myEach(array, function (el) {
    if (value === el) {
      result = true;
    }
  });

  return result;
};

myInclude([1, 2, 3, 4], 6); // => false
myInclude([1, 2, 3, 4], 2); // => true

const myCount = (array, value = null) => {
  let count = 0;

  myEach(array, function (el) {
    if (value !== null) {
      if (value === el) {
        count++;
      }
    } else {
      count++;
    }
  });

  return count;
};

myCount([1, 2, 2, 4, 2, 7, 7, 8]); // => 8
myCount([1, 2, 2, 4, 2, 7, 7, 8], 2); // => 3
myCount([1, 2, 2, 4, 2, 7, 7, 8], 8); // => 1

const myAny = (array, callback) => {
  let result = false;

  myEach(array, function (el) {
    if (callback(el)) {
      result = true;
    }
  });

  return result;
};

myAny([1,2,3,4,15], function(el) { return (el % 3 === 0 ); });
myAny([1,2,3,4,15], function(el) { return (el % 234234 === 0 ); });
