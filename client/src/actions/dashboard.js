import * as DashboardAPI from '../apis/DashboardAPI';

export const FETCH_DASHBOARD_SUCCESS = '[Dashboard] Fetch Success';

export const fetchDashboardSuccess = data => ({
  type: FETCH_DASHBOARD_SUCCESS,
  payload: data
});

export function fetchDashboard() {
  return dispatch =>
    DashboardAPI.getDashboard().then(data => dispatch(fetchDashboardSuccess(data)));
}
