import { ContentPaste, Dashboard, Person, } from '@material-ui/icons';
import { userIsAuthenticatedRedir, userIsNotAuthenticatedRedir } from './auth';
import DashboardContainer from './containers/DashboardContainer';
import LoginContainer from './containers/LoginContainer';

const Login = userIsNotAuthenticatedRedir(LoginContainer);
const DashboardPage = userIsAuthenticatedRedir(DashboardContainer);

const appRoutes = [
  {
    path: '/dashboard',
    sidebarName: 'Dashboard',
    navbarName: 'Material Dashboard',
    icon: Dashboard,
    component: DashboardPage
  },
  {
    path: '/login',
    sidebarName: 'User Profile',
    navbarName: 'Profile',
    icon: Person,
    component: Login
  },
  {
    path: '/table',
    sidebarName: 'Table List',
    navbarName: 'Table List',
    icon: ContentPaste,
    component: Login
  },
  { redirect: true, path: '/', to: '/dashboard', navbarName: 'Redirect' }
];

export default appRoutes;
