import { axios, getToken } from '../utils/api';

export const getAll = () =>
  axios({
    method: 'GET',
    url: '/api/weights',
    responseType: 'json',
    headers: getToken()
  }).then(response => response.data);
