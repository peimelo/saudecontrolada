import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardHeader,
  Grid,
  TextField,
  Typography
} from '@material-ui/core'
import { withStyles } from '@material-ui/core/styles'
import PropTypes from 'prop-types'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { signIn } from '../../actions/userActions'
import { styles } from './styles'

const propTypes = {
  classes: PropTypes.object.isRequired,
  errorMessage: PropTypes.string.isRequired
}

class LoginContainer extends Component {
  state = {
    login: {
      email: '',
      password: ''
    }
  }

  handleChange = (event) => {
    const { target } = event
    const { login } = this.state

    const newLogin = {
      ...login,
      [target.name]: target.value
    }
    this.setState({ login: newLogin })
  }

  handleLogin = (e) => {
    e.preventDefault()
    const { login } = this.state
    this.props
      .signIn(login.email, login.password)
      .then(() => this.props.history.push('/dashboard'))
  }

  render() {
    const { classes, errorMessage } = this.props

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
                <form onSubmit={this.handleLogin} noValidate autoComplete="off">
                  <CardHeader title="Entrar" />
                  <CardContent>
                    <TextField
                      autoFocus
                      margin="dense"
                      id="email"
                      name="email"
                      label="E-mail"
                      type="email"
                      fullWidth
                      onChange={this.handleChange}
                    />
                    <TextField
                      id="password"
                      name="password"
                      label="Senha"
                      type="password"
                      autoComplete="current-password"
                      margin="normal"
                      fullWidth
                      onChange={this.handleChange}
                    />
                  </CardContent>
                  <CardActions>
                    <Button variant="raised" color="primary" type="submit">
                      Enviar
                    </Button>
                    <Typography>{errorMessage}</Typography>
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

LoginContainer.propTypes = propTypes

const mapStateToProps = state => ({
  errorMessage: state.user.errorMessage
})

export default connect(mapStateToProps, {
  signIn
})(withStyles(styles)(LoginContainer))
