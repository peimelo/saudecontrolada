import connectedAuthWrapper from 'redux-auth-wrapper/connectedAuthWrapper';
import locationHelperBuilder from 'redux-auth-wrapper/history4/locationHelper';
import { connectedRouterRedirect } from 'redux-auth-wrapper/history4/redirect';

import Loading from './components/Loading';

const locationHelper = locationHelperBuilder({});

const userIsAuthenticatedDefaults = {
  authenticatedSelector: state => state.user.isLoggedIn === true,
  authenticatingSelector: state => state.user.isLoading,
  wrapperDisplayName: 'UserIsAuthenticated'
};

export const userIsAuthenticated = connectedAuthWrapper(userIsAuthenticatedDefaults);

export const userIsAuthenticatedRedir = connectedRouterRedirect({
  ...userIsAuthenticatedDefaults,
  AuthenticatingComponent: Loading,
  redirectPath: '/login'
});

const userIsNotAuthenticatedDefaults = {
  // Want to redirect the user when they are done loading and authenticated
  authenticatedSelector: state => state.user.isLoggedIn === false && state.user.isLoading === false,
  wrapperDisplayName: 'UserIsNotAuthenticated'
};

export const userIsNotAuthenticated = connectedAuthWrapper(userIsNotAuthenticatedDefaults);

export const userIsNotAuthenticatedRedir = connectedRouterRedirect({
  ...userIsNotAuthenticatedDefaults,
  redirectPath: (state, ownProps) => locationHelper.getRedirectQueryParam(ownProps) || '/dashboard',
  allowRedirectBack: false
});
