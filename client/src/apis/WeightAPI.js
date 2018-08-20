import { BASE_URL } from '../constants/apis'
import { axios, getToken } from '../utils/api';

export const getAll = () =>
  axios({
    method: 'GET',
    url: `${BASE_URL}/api/weights`,
    responseType: 'json',
    headers: getToken()
  }).then(response => response.data);
