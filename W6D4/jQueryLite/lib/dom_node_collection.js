class DOMNodeCollection {
  constructor (htmlElementsArray) {
    this.$elements = htmlElementsArray;
  }

  empty () {
    for (let i = 0; i < this.$elements.length; i++) {
      this.$elements[i].innerHTML = "";
    }
  }

  append (content) {
    if (typeof(content) === "string") {
      for (let i = 0; i < this.$elements.length; i++) {
        this.$elements[i].innerHTML += content;
      }
    } else if (content instanceof HTMLElement) {
      for (let i = 0; i < this.$elements.length; i++) {
        this.$elements[i].innerHTML += content.outerHTML;
      }
    } else if (content instanceof DOMNodeCollection) {
      for (let i = 0; i < this.$elements.length; i++) {
        for (let j = 0; j < content.$elements.length; j++) {
          this.$elements[i].innerHTML += content.$elements[j].outerHTML;
        }
      }
    }
  }

  remove () {

  }

  attr (attributeName, value) {
    if (value) {
      this.$elements[0].setAttribute(attributeName, value);
    } else {
      return this.$elements[0].getAttribute(attributeName);
    }
  }

  addClass (className, value) {
    if (value) {
      this.$elements[0].className = value;
      return this.$elements[0].className;
    }
  }

  removeClass (className) {
    if (this.$elements[0].className === className) {
      this.$elements[0].className = "";
      return this.$elements[0].className;
    }
  }

  html (string) {
    if (typeof(string) === "string") {
      for (let i = 0; i < this.$elements.length; i++) {
        this.$elements[i].innerHTML = string;
      }
    } else {
      return this.$elements[0].innerHTML;
    }
  }

  find () {

  }

  children () {

  }

  parent () {

  }
}

module.exports = DOMNodeCollection;
