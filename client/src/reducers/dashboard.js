import { FETCH_DASHBOARD_SUCCESS } from '../actions/dashboard';

const INITIAL_STATE = {
  weights: []
};

function dashboard(state = INITIAL_STATE, action) {
  switch (action.type) {
    case FETCH_DASHBOARD_SUCCESS:
      return {
        ...state,
        weights: action.payload.weights.map(weight => (
          {
            date: weight.date,
            value: parseInt(weight.value, 10)
          }
        ))
      };
    default:
      return state;
  }
}

export default dashboard;
