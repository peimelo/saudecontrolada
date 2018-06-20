import {
  Drawer,
  IconButton,
  List,
  ListItem,
  ListItemIcon,
  ListItemText
} from '@material-ui/core'
import { withStyles } from '@material-ui/core/styles'
import { ChevronLeft, ChevronRight } from '@material-ui/icons'
import classNames from 'classnames'
import PropTypes from 'prop-types'
import React from 'react'
import { connect } from 'react-redux'
import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom'
import { signOut } from '../../actions/userActions'
import HeaderApp from '../../components/HeaderApp'
import appRoutes from '../../routes'
import { styles } from './styles'

const propTypes = {
  classes: PropTypes.object.isRequired,
  theme: PropTypes.object.isRequired
}

class AppContainer extends React.Component {
  state = {
    open: false
  }

  handleDrawerOpen = () => {
    this.setState({ open: true })
  }

  handleDrawerClose = () => {
    this.setState({ open: false })
  }

  handleLogout() {
    this.props.signOut();
  }

  render() {
    const { classes, theme, user } = this.props
    const { open } = this.state

    const switchRoutes = (
      <Switch>
        {appRoutes.map(prop => (
          <Route
            key={prop.path}
            path={prop.path}
            component={prop.component}
          />
        ))}
      </Switch>
    )

    const links = (
      <div>
        {appRoutes.filter(item => item.menu).map(prop => (
          <div key={prop.path}>
            <ListItem button component={Link} to={prop.path}>
              <ListItemIcon>
                <prop.icon />
              </ListItemIcon>
              <ListItemText
                primary={prop.sidebarName}
              />
            </ListItem>
          </div>
        ))}
      </div>
    )

    return (
      <Router>
        <div className={classes.root}>
          <HeaderApp
            classes={classes}
            open={open}
            user={user}
            handleDrawerOpen={() => this.handleDrawerOpen()}
            handleLogout={() => this.handleLogout()}
          />
          {user.isLoggedIn && (
            <Drawer
              classes={{
                paper: classNames(classes.drawerPaper, !open && classes.drawerPaperClose)
              }}
              open={open}
              variant="permanent"
            >
              <div className={classes.toolbar}>
                <IconButton onClick={this.handleDrawerClose}>
                  {theme.direction === 'rtl' ? <ChevronRight /> :
                    <ChevronLeft />}
                </IconButton>
              </div>
              <List>{links}</List>
            </Drawer>
          )}
          <main className={classes.content}>
            <div className={classes.toolbar} />
            {switchRoutes}
          </main>
        </div>
      </Router>
    )
  }
}

AppContainer.propTypes = propTypes

const mapStateToProps = state => ({
  user: state.user
})

export default connect(
  mapStateToProps,
  { signOut }
)(withStyles(styles, { withTheme: true })(AppContainer))
