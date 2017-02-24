class Clock {
  constructor(){
    let date = new Date;
    let currentHour = date.getHours();
    let currentMinutes = date.getMinutes();
    let currentSeconds = date.getSeconds();
    Clock.printTime(currentHour, currentMinutes, currentSeconds);
    setInterval( () => {
        if (currentSeconds < 59) {
          currentSeconds++;
        } else if (currentMinutes < 59) {
          currentSeconds = 0;
          currentMinutes++;
        } else if (currentHour < 23){
          currentSeconds = 0;
          currentMinutes = 0;
          currentHour++;
        } else {
          currentSeconds = 0;
          currentMinutes = 0;
          currentHour = 0;
        }
        Clock.printTime(currentHour, currentMinutes, currentSeconds);
      }, 1000);

  }
  static printTime(h, m, s){
    console.log(`${h}:${m}:${s}`);
  }
}

// const clock = new Clock();

const addNumbersPremium = (currentSum = 0) => {
  const readline = require('readline');

  const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  reader.question("Enter a number: ", function (number) {
    if(parseInt(number)){
      const nextNumber = parseInt(number);
      let newSum = currentSum + nextNumber;
      console.log(newSum);
      addNumbersPremium(newSum);
    } else {
      console.log(currentSum);
      reader.close();
    }
  });
};

// addNumbersPremium();

const addNumbersTrial = (sum, numsLeft, completionCallback) => {
  const readline = require('readline');

  const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  if (numsLeft > 0){
    reader.question("Enter a number: ", function(number){
      const nextNumber = parseInt(number);
      let newSum = sum + nextNumber;
      console.log(newSum);
      addNumbersTrial(newSum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
};

// addNumbersTrial(0, 3, sum => console.log(`Total Sum: ${sum}`));

function askIfGreaterThan(el1, el2, callback) {
  const readline = require('readline');

  const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  reader.question(`Is ${el1} greater than ${el2}? (y/n)`, function (usersOpinion) {
    if (usersOpinion === "y"){
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i === (arr.length - 1)){
    outerBubbleSortLoop(madeAnySwaps);
  } else {
    askIfGreaterThan(arr[i], arr[i + 1], function(shouldSwap){
      if (shouldSwap) {
        let tempVar = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = tempVar;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, (i + 1), madeAnySwaps, outerBubbleSortLoop);
    });

  }
}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {

    if (madeAnySwaps){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }

  }
  outerBubbleSortLoop(true);
}

// absurdBubbleSort([5, 4, 7, 1, 2], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });
