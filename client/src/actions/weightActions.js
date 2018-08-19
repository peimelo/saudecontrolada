import * as WeightAPI from '../apis/WeightAPI'
import { FETCH_WEIGHTS_SUCCESS } from '../constants/weightActionTypes'

export const fetchWeightsSuccess = data => ({
  type: FETCH_WEIGHTS_SUCCESS,
  payload: data
});

export function fetchWeights() {
  return dispatch =>
    WeightAPI.getAll().then(data => dispatch(fetchWeightsSuccess(data)));
}
