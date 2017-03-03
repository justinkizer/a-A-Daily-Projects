const Router = require("./router.js");
const Inbox = require("./inbox.js");

document.addEventListener("DOMContentLoaded", addListeners);

function addListeners (event) {
  $(".sidebar-nav li").each((i, el) => {
    el.addEventListener("click", listenerHelper);
  });
}

function listenerHelper (event) {
  event.preventDefault();
  let location = event.target.innerText.toLowerCase();
  window.location.hash = location;
  let router = new Router(document.querySelector(".content"), routes);
  router.start();
}

const routes = {
  compose: undefined,
  inbox: Inbox,
  sent: undefined
};
