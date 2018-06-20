import {
  AppBar,
  Button,
  Divider,
  IconButton,
  Menu,
  MenuItem,
  Toolbar,
  Typography
} from '@material-ui/core'
import { Menu as MenuIcon, AccountCircle } from '@material-ui/icons'
import classNames from 'classnames'
import PropTypes from 'prop-types'
import React from 'react'
import { Link } from 'react-router-dom'

const propTypes = {
  classes: PropTypes.object.isRequired
}

class HeaderApp extends React.Component {
  state = {
    anchorEl: null
  }

  handleClose = () => {
    this.setState({ anchorEl: null })
  }

  handleLogout = () => {
    this.handleClose()
    this.props.handleLogout()
  }

  handleMenu = event => {
    this.setState({ anchorEl: event.currentTarget })
  }

  render() {
    const { classes, open, user, handleDrawerOpen } = this.props
    const { anchorEl } = this.state
    const openMenu = Boolean(anchorEl)

    return (
      <AppBar
        position="absolute"
        className={classNames(classes.appBar, open && classes.appBarShift)}
      >
        <Toolbar disableGutters={!open}>
          {user.isLoggedIn && (
            <IconButton
              aria-label="open drawer"
              className={classNames(classes.menuButton, open && classes.hide)}
              color="inherit"
              onClick={() => handleDrawerOpen()}
            >
              <MenuIcon />
            </IconButton>
          )}
          <Typography
            className={classes.flex}
            color="inherit"
            noWrap
            variant="title"
          >
            Saúde Controlada
          </Typography>
          {user.isLoggedIn ? (
            <div>
              <IconButton
                aria-owns={open ? 'menu-appbar' : null}
                aria-haspopup="true"
                onClick={this.handleMenu}
                color="inherit"
              >
                <AccountCircle />
              </IconButton>
              <Menu
                id="menu-appbar"
                anchorEl={anchorEl}
                anchorOrigin={{
                  vertical: 'top',
                  horizontal: 'right'
                }}
                transformOrigin={{
                  vertical: 'top',
                  horizontal: 'right'
                }}
                open={openMenu}
                onClose={this.handleClose}
              >
                <MenuItem onClick={this.handleClose}>Profile</MenuItem>
                <MenuItem onClick={this.handleClose}>My account</MenuItem>
                <Divider />
                <MenuItem onClick={this.handleLogout}>Sair</MenuItem>
              </Menu>
            </div>
          ) : (
            <Button
              color="inherit"
              component={Link}
              to="/login"
            >
              Entrar
            </Button>
          )}
        </Toolbar>
      </AppBar>
    )
  }
}

HeaderApp.propTypes = propTypes

export default HeaderApp
