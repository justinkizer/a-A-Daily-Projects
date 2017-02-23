const MyRange = (start, end) => {
  if (start > end) {
    return [];
  }

  if (start + 2 === end) {
    return [start + 1];
  }

  return [start + 1].concat(MyRange(start + 1, end));
};

MyRange(1, 5); // => [2, 3, 4]
