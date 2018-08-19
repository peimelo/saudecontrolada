import { FETCH_WEIGHTS_SUCCESS } from '../constants/weightActionTypes'

const INITIAL_STATE = {
  data: []
};

function weights(state = INITIAL_STATE, action) {
  switch (action.type) {
    case FETCH_WEIGHTS_SUCCESS:
      console.log(action.payload)
      return {
        ...state,
        data: action.payload.weights
      };
    default:
      return state;
  }
}

export default weights;
