import * as DashboardAPI from '../apis/DashboardAPI'
import { FETCH_DASHBOARD_SUCCESS } from '../constants/dashboardActionTypes'

export const fetchDashboardSuccess = data => ({
  type: FETCH_DASHBOARD_SUCCESS,
  payload: data
});

export function fetchDashboard() {
  return dispatch =>
    DashboardAPI.getDashboard().then(data => dispatch(fetchDashboardSuccess(data)));
}
