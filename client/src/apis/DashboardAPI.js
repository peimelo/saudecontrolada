import { axios, getToken } from '../utils/api';

export const getDashboard = () =>
  axios({
    method: 'GET',
    url: '/api/dashboards',
    responseType: 'json',
    headers: getToken()
  }).then(response => response.data);
