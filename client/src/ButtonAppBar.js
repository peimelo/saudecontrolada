import React, { Component } from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import { withStyles } from 'material-ui/styles';
import AppBar from 'material-ui/AppBar';
import Toolbar from 'material-ui/Toolbar';
import Typography from 'material-ui/Typography';
import Button from 'material-ui/Button';
import IconButton from 'material-ui/IconButton';
import MenuIcon from 'material-ui-icons/Menu';
import { Link } from 'react-router-dom';

const styles = {
  root: {
    flexGrow: 1,
  },
  flex: {
    flex: 1,
  },
  menuButton: {
    marginLeft: -12,
    marginRight: 20,
  },
  link: {
    textDecoration: 'none'
  }
};

class ButtonAppBar extends Component {
  render() {
    const { classes, user } = this.props;

    return (
      <div className={classes.root}>
        <AppBar position="static">
          <Toolbar>
            {user.isLogged && (
              <IconButton
                aria-label="Menu"
                className={classes.menuButton}
                color="inherit"
              >
                <MenuIcon />
              </IconButton>
            )}
            <Typography
              className={classes.flex}
              color="inherit"
              component={Link} to='/'
              style={styles.link}
              variant="title"
            >
              SIGR
            </Typography>
            {user.isLogged ?
              <Button
                color="inherit"
              >
                {user.data.name}
              </Button>
              :
              <Button
                color="inherit"
                component={Link}
                to='/login'
              >
                {'Login'}
              </Button>
            }
          </Toolbar>
        </AppBar>
      </div>
    );
  }
}

ButtonAppBar.propTypes = {
  classes: PropTypes.object.isRequired,
};

const mapStateToProps = state => ({
  user: state.user
});

export default connect(mapStateToProps, {
})(withStyles(styles)(ButtonAppBar))
