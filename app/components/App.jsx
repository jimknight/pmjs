// var Router = require('react-router'); // or var Router = ReactRouter; in browsers

// var DefaultRoute = Router.DefaultRoute;
// var Link = Router.Link;
// var Route = Router.Route;
// var RouteHandler = Router.RouteHandler;

var App = React.createClass({
  render: function () {
    return (
      <div>
        <header>
          <ul>
            // <li><Link to="app">Dashboard</Link></li>
            // <li><Link to="inbox">Inbox</Link></li>
            // <li><Link to="calendar">Calendar</Link></li>
          </ul>
          Logged in as Jane
        </header>

        {/* this is the important part */}
        // <RouteHandler/>
      </div>
    );
  }
});