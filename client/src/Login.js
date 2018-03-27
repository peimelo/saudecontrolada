import React, { Component } from 'react';

import * as AuthAPI from './utils/AuthAPI';

class Login extends Component {
  state = {
    user: {
      id: '',
      name: ''
    }
  };

  handleLogin = (e) => {
    e.preventDefault();

    AuthAPI.sign_in(this.email.value, this.password.value)
      .then((res) => this.setState({ user: res.data }));
  };

  render() {
    return (
      <div>
        <h2>Sign in</h2>
        <form onSubmit={this.handleLogin}>
          <input name="email" ref={(input) => this.email = input}/>
          <input name="password" type="password"
                 ref={(input) => this.password = input}/>
          <input type="submit"/>
        </form>
        <hr />
        User: { this.state.user.name }
      </div>
    )
  }
}

export default Login;
