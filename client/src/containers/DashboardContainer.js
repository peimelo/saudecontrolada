import moment from 'moment';
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { CartesianGrid, Line, LineChart, XAxis, YAxis } from 'recharts';
import Typography from '@material-ui/core/Typography';
import { fetchDashboard } from '../actions/dashboard';

class DashboardContainer extends Component {
  componentDidMount() {
    this.props.fetchDashboard();
  }

  formatXAxis(tickItem) {
    return moment(tickItem).format('DD/MM/YYYY');
  }

  render() {
    const { weights } = this.props;

    return (
      <div>
        <Typography gutterBottom variant="headline" component="h2">
          Dashboard
        </Typography>
        <LineChart width={500} height={300} data={weights}>
          <XAxis dataKey="date" tickFormatter={this.formatXAxis} />
          <YAxis />
          <CartesianGrid stroke="#eee" strokeDasharray="5 5" />
          <Line type="monotone" dataKey="value" stroke="#8884d8" />
        </LineChart>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  weights: state.dashboard.weights
});

export default connect(mapStateToProps, {
  fetchDashboard
})(DashboardContainer);
