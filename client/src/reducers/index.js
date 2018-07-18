import { combineReducers } from 'redux';

import dashboard from './dashboard';
import user from './user';
import weights from './weights';

const rootReducer = combineReducers({
  dashboard,
  user,
  weights
});

export default rootReducer;
