import { userIsAuthenticatedRedir, userIsNotAuthenticatedRedir } from './auth'
import DashboardContainer from './containers/DashboardContainer'
import LoginContainer from './containers/LoginContainer'
import WeightContainer from './containers/WeightContainer'

const LoginPage = userIsNotAuthenticatedRedir(LoginContainer);
const DashboardPage = userIsAuthenticatedRedir(DashboardContainer);
const WeightPage = userIsAuthenticatedRedir(WeightContainer);

const appRoutes = [
  {
    path: '/login',
    sidebarName: 'Login',
    icon: 'user',
    component: LoginPage,
    menu: false
  },
  {
    path: '/dashboard',
    sidebarName: 'Dashboard',
    icon: 'tachometer-alt',
    component: DashboardPage,
    menu: true
  },
  {
    path: '/weight',
    sidebarName: 'Weight',
    icon: 'weight',
    component: WeightPage,
    menu: true
  }
];

export default appRoutes;
