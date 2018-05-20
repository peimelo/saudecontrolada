import {
  Divider,
  Drawer,
  IconButton,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Typography
} from '@material-ui/core';
import { withStyles } from '@material-ui/core/styles';
import { ChevronLeft, ChevronRight } from '@material-ui/icons';
import classNames from 'classnames';
import PropTypes from 'prop-types';
import React from 'react';
import { connect } from 'react-redux';
import {
  BrowserRouter as Router,
  NavLink,
  Route,
  Switch
} from 'react-router-dom';
import HeaderApp from '../components/HeaderApp';
import appRoutes from '../routes';
import { mailFolderListItems, otherMailFolderListItems } from './tileData';
import LoginContainer from './LoginContainer';
import DashboardContainer from './DashboardContainer';

const drawerWidth = 240;

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: 430,
    zIndex: 1,
    overflow: 'hidden',
    position: 'relative',
    display: 'flex',
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  },
  appBarShift: {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  menuButton: {
    marginLeft: 12,
    marginRight: 36,
  },
  hide: {
    display: 'none',
  },
  drawerPaper: {
    position: 'relative',
    whiteSpace: 'nowrap',
    width: drawerWidth,
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerPaperClose: {
    overflowX: 'hidden',
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    width: theme.spacing.unit * 7,
    [theme.breakpoints.up('sm')]: {
      width: theme.spacing.unit * 9,
    },
  },
  toolbar: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: '0 8px',
    ...theme.mixins.toolbar,
  },
  content: {
    flexGrow: 1,
    backgroundColor: theme.palette.background.default,
    padding: theme.spacing.unit * 3,
  },
});

class App extends React.Component {
  state = {
    open: false,
  };

  handleDrawerOpen = () => {
    console.log('abrir');
    this.setState({ open: true });
  };

  handleDrawerClose = () => {
    console.log('fechar');
    this.setState({ open: false });
  };

  render() {
    const { classes, theme, user } = this.props;

    const switchRoutes = (
      <Switch>
        {appRoutes.map((prop, key) => {
          return <Route path={prop.path} component={prop.component} key={key} />;
        })}
      </Switch>
    );

    const links = (
      <List className={classes.list}>
        {appRoutes.map((prop, key) => {
          return (
            <NavLink
              to={prop.path}
              className={classes.item}
              activeClassName="active"
              key={key}
            >
              <ListItem button>
                <ListItemIcon>
                  <ChevronRight />
                </ListItemIcon>
                <ListItemText
                  primary={prop.sidebarName}
                />
              </ListItem>
            </NavLink>
          );
        })}
      </List>
    );

    return (
      <Router>
        <div className={classes.root}>
          <HeaderApp
            classes={classes}
            open={this.state.open}
            user={user}
            handleDrawerOpen={() => this.handleDrawerOpen()}
          />
          <Drawer
            variant="permanent"
            classes={{
              paper: classNames(classes.drawerPaper, !this.state.open && classes.drawerPaperClose),
            }}
            open={this.state.open}
          >
            <div className={classes.toolbar}>
              <IconButton onClick={this.handleDrawerClose}>
                {theme.direction === 'rtl' ? <ChevronRight /> : <ChevronLeft />}
              </IconButton>
            </div>
            <Divider />
            {links}
            <List>{mailFolderListItems}</List>
            <Divider />
            <List>{otherMailFolderListItems}</List>
          </Drawer>
          <main className={classes.content}>
            <div className={classes.toolbar} />
            <Typography noWrap>
              {switchRoutes}
            </Typography>
          </main>
        </div>
      </Router>
    );
  }
}

App.propTypes = {
  classes: PropTypes.object.isRequired,
  theme: PropTypes.object.isRequired,
};

const mapStateToProps = state => ({
  user: state.user
});

export default connect(mapStateToProps, {})(withStyles(styles, { withTheme: true })(App));
