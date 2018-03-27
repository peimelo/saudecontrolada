import axios from 'axios';

const api = process.env.REACT_APP_CONTACTS_API_URL || '';
const headers = {
  'Accept': 'application/json',
};

export const sign_in = (email, password) =>
  axios({
    method: 'POST',
    url: `${api}/auth/sign_in`,
    responseType: 'json',
    data: JSON.stringify({
      email,
      password
    }),
    headers: {
      ...headers,
      'Content-Type': 'application/json'
    }
  })
    .then((response) => {
      sessionStorage.setItem(
        'user',
        JSON.stringify({
          'access-token': response.headers['access-token'],
          client: response.headers['client'],
          uid: response.headers['uid']
        })
      );

      return response.data;
    });

export const sign_out = () =>
  axios({
    method: 'DELETE',
    url: `${api}/auth/sign_out`,
    responseType: 'json',
    data: JSON.parse(sessionStorage.getItem('user')),
    headers: {
      ...headers,
      'Content-Type': 'application/json'
    }
  })
    .then(() => sessionStorage.removeItem('user'));

export const validate_token = () =>
  axios({
    method: 'GET',
    url: `${api}/auth/validate_token`,
    responseType: 'json',
    data: JSON.parse(sessionStorage.getItem('user')),
    headers
  })
    .then(() => sessionStorage.removeItem('user'));
