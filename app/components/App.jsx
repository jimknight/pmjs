var React = require('react');
var Router = require('react-router'); // or var Router = ReactRouter; in browsers

var DefaultRoute = Router.DefaultRoute;
var Link = Router.Link;
var Route = Router.Route;
var RouteHandler = Router.RouteHandler;

var Calendar = React.createClass({
  render: function() {
    return (
      <h2>Calender</h2>
    );
  }
});

var EmailBody = React.createClass({
  render: function() {
    return (
      <h2>email_body</h2>
    );
  }
});

var Inbox = React.createClass({
  render: function() {
    return (
      <h2>inbox</h2>
    );
  }
});

var ProjectShowAction = React.createClass({
  render: function() {
    return (
      <h2>project_show_action</h2>
    );
  }
});

var App = React.createClass({
  render: function () {
    return (
      <div>
        <header>
          <ul>
            <li><Link to="app">Dashboard</Link></li>
            <li><Link to="inbox">Inbox</Link></li>
            <li><Link to="calendar">Calendar</Link></li>
          </ul>
          Logged in as Jane
        </header>

        {/* this is the important part */}
        <RouteHandler/>
      </div>
    );
  }
});

var routes = (
  <Route name="app" path="/" handler={App}>
    <Route name="inbox" handler={Inbox}/>
    <Route name="calendar" handler={Calendar}/>
    <DefaultRoute handler={Dashboard}/>
  </Route>
);

Router.run(routes, function (Handler) {
  React.render(<Handler/>, document.getElementById('reactapp'));
});