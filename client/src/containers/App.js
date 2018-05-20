import React from 'react';
import { connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { userIsAuthenticatedRedir, userIsNotAuthenticatedRedir } from '../auth';
import HeaderApp from '../components/HeaderApp';
import DashboardContainer from './DashboardContainer';
import LoginContainer from './LoginContainer';

// Need to apply the hocs here to avoid applying them inside the render method
const Login = userIsNotAuthenticatedRedir(LoginContainer);
const Dashboard = userIsAuthenticatedRedir(DashboardContainer);

function App({ user }) {
  return (
    <Router>
      <div>
        <HeaderApp user={user} />
        <Route path="/login" component={Login} />
        <Route path="/dashboard" component={Dashboard} />
      </div>
    </Router>
  );
}

const mapStateToProps = state => ({
  user: state.user
});

export default connect(mapStateToProps, {})(App);
