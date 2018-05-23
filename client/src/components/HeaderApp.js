import classNames from 'classnames';
import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import MenuIcon from '@material-ui/icons/Menu';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton';

const propTypes = {
  classes: PropTypes.object.isRequired
};

function HeaderApp({ classes, open, handleDrawerOpen }) {
  return (
    <AppBar
      position="absolute"
      className={classNames(classes.appBar, open && classes.appBarShift)}
    >
      <Toolbar disableGutters={!open}>
        <IconButton
          color="inherit"
          aria-label="open drawer"
          onClick={() => handleDrawerOpen()}
          className={classNames(classes.menuButton, open && classes.hide)}
        >
          <MenuIcon />
        </IconButton>
        <Typography
          variant="title"
          color="inherit"
          noWrap
          component={Link}
          to="/"
        >
          Saúde Controlada
        </Typography>
      </Toolbar>
    </AppBar>
  );
}

HeaderApp.propTypes = propTypes;

export default HeaderApp;
