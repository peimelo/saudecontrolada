import * as AuthAPI from '../utils/AuthAPI'

export const USER_SIGN_IN_SUCCESS = 'USER_SIGN_IN_SUCCESS';

export function signIn(email, password) {
  return dispatch => {
    return AuthAPI
      .sign_in(email, password)
      .then((user) => dispatch(userSignInSuccess(user)))
  }
}
export const userSignInSuccess = user => ({
  type: USER_SIGN_IN_SUCCESS,
  payload: user
});
