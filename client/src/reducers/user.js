import { USER_SIGN_IN_SUCCESS } from '../actions/user';

const INITIAL_STATE = {
  data: {
    id: '',
    login: '',
  },
  isLogged: false
};

function user(state = INITIAL_STATE, action) {
  switch (action.type) {
    case USER_SIGN_IN_SUCCESS:
      return {
        ...state,
        data: action.payload.data,
        isLogged: true
      };
    default:
      return state
  }
}

export default user
