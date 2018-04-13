import React, { Component } from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import Button from 'material-ui/Button';
import Card, { CardActions, CardContent, CardHeader } from 'material-ui/Card';
import Grid from 'material-ui/Grid';
import TextField from 'material-ui/TextField';
import { withStyles } from 'material-ui/styles';

import { signIn } from './actions/user';

const styles = {
  root: {
    flexGrow: 1,
  },
  grid: {
    height: 340,
  },
  card: {
    minWidth: 275,
  },
};

class Login extends Component {
  state = {
    login: {
      email: '',
      password: '',
    },
  };

  handleChange = (event) => {
    const target = event.target;
    const { login } = this.state;

    const newLogin = {
      ...login,
      [target.name]: target.value
    };
    this.setState({ login: newLogin });
  };

  handleLogin = (e) => {
    e.preventDefault();
    const { login } = this.state;
    this.props.signIn(login.email, login.password)
      .then(() => this.props.history.push('/dashboard'))
  };

  render() {
    const { classes } = this.props;

    return (
      <Grid container className={classes.root}>
        <Grid item xs={12}>
          <Grid
            container
            className={classes.grid}
            alignItems="center"
            direction="row"
            justify="center"
          >
            <Grid item>
              <Card className={classes.card}>
                <form
                  onSubmit={this.handleLogin}
                  noValidate
                  autoComplete="off"
                >
                  <CardHeader title="Login" />
                  <CardContent>
                    <TextField
                      autoFocus
                      margin="dense"
                      id="email"
                      name="email"
                      label="Email Address"
                      type="email"
                      fullWidth
                      onChange={this.handleChange}
                    />
                    <TextField
                      id="password"
                      name="password"
                      label="Password"
                      type="password"
                      autoComplete="current-password"
                      margin="normal"
                      fullWidth
                      onChange={this.handleChange}
                    />
                  </CardContent>
                  <CardActions>
                    <Button
                      variant="raised"
                      color="primary"
                      type="submit"
                    >
                      Enviar
                    </Button>
                  </CardActions>
                </form>
              </Card>
            </Grid>
          </Grid>
        </Grid>
      </Grid>
    )
  }
}

Login.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default connect(null, {
  signIn,
})(withStyles(styles)(Login))
