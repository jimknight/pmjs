var React = require('react');
var Router = require('react-router'); // or var Router = ReactRouter; in browsers

var DefaultRoute = Router.DefaultRoute;
var Link = Router.Link;
var Route = Router.Route;
var RouteHandler = Router.RouteHandler;

var App = React.createClass({displayName: "App",
  render: function () {
    return (
      React.createElement("div", null, 
        React.createElement("header", null, 
          React.createElement("ul", null, 
            React.createElement("li", null, React.createElement(Link, {to: "app"}, "Dashboard")), 
            React.createElement("li", null, React.createElement(Link, {to: "inbox"}, "Inbox")), 
            React.createElement("li", null, React.createElement(Link, {to: "calendar"}, "Calendar"))
          ), 
          "Logged in as Jane"
        ), 

        /* this is the important part */
        React.createElement(RouteHandler, null)
      )
    );
  }
});

var routes = (
  React.createElement(Route, {name: "app", path: "/", handler: App}, 
    React.createElement(Route, {name: "inbox", handler: Inbox}), 
    React.createElement(Route, {name: "calendar", handler: Calendar}), 
    React.createElement(DefaultRoute, {handler: Dashboard})
  )
);

Router.run(routes, function (Handler) {
  React.render(React.createElement(Handler, null), document.getElementById('reactapp'));
});
var Calendar = React.createClass({displayName: "Calendar",
  render: function() {
    return (
      React.createElement("h2", null, "Calendar")
    );
  }
});
var Dashboard = React.createClass({displayName: "Dashboard",
  render: function() {
    return (
      React.createElement("h2", null, "Dashboard")
    );
  }
});
var EmailBody = React.createClass({displayName: "EmailBody",
  render: function() {
    return (
      React.createElement("h2", null, "email_body")
    );
  }
});
var Inbox = React.createClass({displayName: "Inbox",
  render: function() {
    return (
      React.createElement("h2", null, "inbox")
    );
  }
});
var Menu = React.createClass({displayName: "Menu",
  render: function() {
    return (
      React.createElement("h2", null, "Menu")
    );
  }
});
var ProjectShowAction = React.createClass({displayName: "ProjectShowAction",
  render: function() {
    return (
      React.createElement("h2", null, "project_show_action")
    );
  }
});