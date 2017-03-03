function Router (node, routes) {
  this.node = node;
  this.routes = routes;
}

Router.prototype.start = function () {
  this.render();
  window.addEventListener("hashchange", this.render.bind(this));
};

Router.prototype.activeRoute = function () {
  console.log(this.routes[`${window.location.hash.slice(1)}`]);
  return window.location.hash.slice(1);
};

Router.prototype.render = function (node) {
  this.node.innerHTML = "";
  let newRoute = this.activeRoute();
  let newNode = document.createElement("p");
  newNode.innerHTML = newRoute;
  this.node.appendChild(newNode);
};

module.exports = Router;
//
// Change activeRoute.
// activeRoute should return the component that matches the current route instead of just returning the name of the route.
//
// Look up the appropriate component for the current route by accessing the this.routes object using the location name you retrieved from the hash. Make sure you have removed "#" from the name.
// Return the component.
