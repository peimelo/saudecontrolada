import { ConnectedRouter } from 'connected-react-router'
import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import AppContainer from './containers/AppContainer'
import './index.css'
import registerServiceWorker from './registerServiceWorker'
import store, { history } from './store'
import fa from './components/FontAwesomeIcons'

ReactDOM.render(
  <Provider store={store}>
    <ConnectedRouter history={history}>
    <AppContainer />
    </ConnectedRouter>
  </Provider>,
  document.getElementById('root'),
);
registerServiceWorker();
