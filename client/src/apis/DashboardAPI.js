import { BASE_URL } from '../constants/apis'
import { axios, getToken } from '../utils/api';

export const getDashboard = () =>
  axios({
    method: 'GET',
    url: `${BASE_URL}/api/dashboards`,
    responseType: 'json',
    headers: getToken()
  }).then(response => response.data);
