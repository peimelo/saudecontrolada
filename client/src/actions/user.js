import * as AuthAPI from '../apis/AuthAPI';

export const USER_SIGN_IN = 'USER_SIGN_IN';
export const USER_SIGN_IN_ERROR = 'USER_SIGN_IN_ERROR';
export const USER_SIGN_IN_SUCCESS = 'USER_SIGN_IN_SUCCESS';

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
