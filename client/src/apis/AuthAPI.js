import { BASE_URL } from '../constants/apis'
import { axios, getToken } from '../utils/api'

export const signIn = (email, password) =>
  axios({
    method: 'POST',
    url: `${BASE_URL}/auth/sign_in`,
    responseType: 'json',
    data: JSON.stringify({
      email,
      password
    })
  }).then((response) => {
    console.log(response);
    sessionStorage.setItem(
      'user',
      JSON.stringify({
        'access-token': response.headers['access-token'],
        client: response.headers.client,
        uid: response.headers.uid
      })
    )

    return response.data
  })

export const signOut = () =>
  axios({
    method: 'DELETE',
    url: `${BASE_URL}/auth/sign_out`,
    responseType: 'json',
    data: JSON.parse(sessionStorage.getItem('user'))
  }).then(() => sessionStorage.removeItem('user'))

export const validateToken = () =>
  axios({
    method: 'GET',
    url: `${BASE_URL}/auth/validate_token`,
    headers: getToken()
  }).then(res => res.data)
