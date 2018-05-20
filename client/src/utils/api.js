import client from 'axios';
import { ROOT_URL } from '../constants/apis';

client.defaults.headers.common.Accept = 'application/json';
client.defaults.headers.post['Content-Type'] = 'application/json';

export const axios = client.create({
  baseURL: ROOT_URL,
  Accept: 'application/json'
});

export function getToken() {
  const user = JSON.parse(sessionStorage.getItem('user'));
  return {
    access_token: (user && user['access-token']) || '',
    client: (user && user['client']) || '',
    uid: (user && user['uid']) || ''
  };
}
