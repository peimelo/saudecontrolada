import { combineReducers } from 'redux';

import dashboard from './dashboard';
import user from './user';

const rootReducer = combineReducers({
  dashboard,
  user
});

export default rootReducer;
