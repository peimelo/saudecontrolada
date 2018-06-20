import {
  USER_SIGN_IN,
  USER_SIGN_IN_ERROR,
  USER_SIGN_IN_SUCCESS,
  USER_SIGN_OUT_SUCCESS
} from '../constants/userActionTypes'

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

    case USER_SIGN_OUT_SUCCESS: {
      return INITIAL_STATE;
    }

    default:
      return state;
  }
}

export default user;
