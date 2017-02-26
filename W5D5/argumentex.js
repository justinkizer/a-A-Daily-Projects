function sum() {
  let result = 0;
  for (let i = 0; i < arguments.length; i++) {
    result += arguments[i];
  }
  return result;
}

console.log(sum(1, 2, 3, 4) === 10);
console.log(sum(1, 2, 3, 4, 5) === 15);

function sum2(...args) {
  let result = 0;
  args.forEach( (el) => {result += el;} );
  return result;
}

console.log(sum2(1, 2, 3, 4) === 10);
console.log(sum2(1, 2, 3, 4, 5) === 15);

Function.prototype.myBind = function (ctx, ...bindArgs) {
  return (...callArgs) =>  {
    return this.apply(ctx, bindArgs.concat(callArgs));
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBind(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(breakfast, "meow")("Markov");
// Breakfast says meow to Markov!
// true

function curriedSum(numArgs) {
  let numbers = [];
  function _curriedSum(n) {
    numbers.push(n);
    if (numbers.length === numArgs) {
      let sumResult = 0;
      numbers.forEach( (el) => {sumResult += el;});
      return sumResult;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

const sumVariable = curriedSum(4);
console.log(sumVariable(5)(30)(20)(1)); // => 56

Function.prototype.curry = function (numArgs) {

  let that = this;
  let args = [];

  function innercurry(arg) {
    args.push(arg);
    if (numArgs === args.length) {
      return that(...args);
    } else {
      return innercurry;
    }
  }
  return innercurry;
};

function logSomeStuff(...loggedArgs) {
  console.log(loggedArgs);
}

const logs = logSomeStuff.curry(4);
logs(1);
logs(2);
logs(3);
logs(4);
