import {
  USER_SIGN_IN,
  USER_SIGN_IN_ERROR,
  USER_SIGN_IN_SUCCESS
} from '../actions/user';

const INITIAL_STATE = {
  data: {
    id: '',
    login: ''
  },
  errorMessage: '',
  isLoading: false,
  isLoggedIn: false
};

function user(state = INITIAL_STATE, action) {
  switch (action.type) {
    case USER_SIGN_IN: {
      return {
        ...state,
        errorMessage: '',
        isLoading: true
      };
    }
    case USER_SIGN_IN_ERROR: {
      return {
        ...state,
        errorMessage: action.payload.errors[0],
        isLoading: false
      };
    }
    case USER_SIGN_IN_SUCCESS: {
      return {
        ...state,
        data: action.payload.data,
        errorMessage: '',
        isLoading: false,
        isLoggedIn: true
      };
    }
    default:
      return state;
  }
}

export default user;
