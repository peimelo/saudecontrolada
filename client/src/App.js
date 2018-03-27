import React, { Component } from 'react';

import Login from './Login';
import ButtonAppBar from './ButtonAppBar';

class App extends Component {
  render() {
    return (
      <div>
        <ButtonAppBar />
        <Login />
      </div>
    );
  }
}

export default App;
