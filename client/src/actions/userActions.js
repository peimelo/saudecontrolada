import * as AuthAPI from '../apis/AuthAPI';
import {
  USER_SIGN_IN,
  USER_SIGN_IN_ERROR,
  USER_SIGN_IN_SUCCESS,
  USER_SIGN_OUT,
  USER_SIGN_OUT_ERROR,
  USER_SIGN_OUT_SUCCESS
} from '../constants/userActionTypes'

export const userSignIn = () => ({
  type: USER_SIGN_IN
});

export const userSignInError = error => ({
  type: USER_SIGN_IN_ERROR,
  payload: error
});

export const userSignInSuccess = user => ({
  type: USER_SIGN_IN_SUCCESS,
  payload: user
});

export function signIn(email, password) {
  return dispatch => {
    dispatch(userSignIn());

    return AuthAPI.signIn(email, password)
      .then(user => dispatch(userSignInSuccess(user)))
      .catch(error => dispatch(userSignInError(error.response.data)));
  };
}

export const userSignOut = () => ({
  type: USER_SIGN_OUT
});

export const userSignOutError = error => ({
  type: USER_SIGN_OUT_ERROR,
  payload: error
});

export const userSignOutSuccess = user => ({
  type: USER_SIGN_OUT_SUCCESS,
  payload: user
});

export function signOut() {
  return dispatch => {
    dispatch(userSignOut());

    return AuthAPI.signOut()
      .then(() => dispatch(userSignOutSuccess()))
      .catch(error => dispatch(userSignOutError(error.response.data)));
  };
}
