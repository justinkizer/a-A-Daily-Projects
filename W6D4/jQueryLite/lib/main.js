const DOMNodeCollection = require("./dom_node_collection.js");
const coreFunction = function (selector) {
  let htmlElementsArray;
  if (typeof(selector) === "string") {
    htmlElementsArray = Array.from(document.querySelectorAll(selector));
  } else if (selector instanceof HTMLElement) {
    htmlElementsArray = Array.from(selector);
    if (htmlElementsArray.length === 0) {
      htmlElementsArray = [selector];
    }
  }
  return new DOMNodeCollection(htmlElementsArray);
};
window.$l = coreFunction;

module.exports = coreFunction;
