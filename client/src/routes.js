import { Dashboard, Person, } from '@material-ui/icons';
import { userIsAuthenticatedRedir, userIsNotAuthenticatedRedir } from './auth';
import DashboardContainer from './containers/DashboardContainer';
import LoginContainer from './containers/LoginContainer';

const LoginPage = userIsNotAuthenticatedRedir(LoginContainer);
const DashboardPage = userIsAuthenticatedRedir(DashboardContainer);

const appRoutes = [
  {
    path: '/login',
    sidebarName: 'Login',
    icon: Person,
    component: LoginPage,
    menu: false
  },
  {
    path: '/dashboard',
    sidebarName: 'Dashboard',
    icon: Dashboard,
    component: DashboardPage,
    menu: true
  }
];

export default appRoutes;
