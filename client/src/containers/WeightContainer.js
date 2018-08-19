import { withStyles } from '@material-ui/core/styles/index'
import moment from 'moment';
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { CartesianGrid, Line, LineChart, XAxis, YAxis } from 'recharts';
import {
  Button,
  Card,
  CardHeader,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableFooter,
  TableHead,
  TablePagination,
  TableRow,
  Typography
} from '@material-ui/core'
import { fetchWeights } from '../actions/weightActions';
import PropTypes from 'prop-types'

// import { styles } from './AppContainer/styles'

const styles = theme => ({
  root: {
    overflowX: 'auto',
    margin: theme.spacing.unit * 2
  },
  container: {
    margin: theme.spacing.unit * 2
  },
  fab: {
    position: 'absolute',
    top: theme.spacing.unit * 10,
    right: theme.spacing.unit * 2,
  },
  paper: {
    maxHeight: 435,
    textAlign: 'center',
    rounded: true
  },
  typography: {
    margin: theme.spacing.unit * 2
  },
  table: {
    minWidth: 700
  },
  row: {
    '&:nth-of-type(odd)': {
      backgroundColor: theme.palette.background.default
    }
  }
})

const CustomTableCell = withStyles(theme => ({
  head: {
    backgroundColor: 'gray',
    color: theme.palette.common.white
  },
  body: {
    fontSize: 14
  }
}))(TableCell)

const propTypes = {
  classes: PropTypes.object.isRequired,
}

class WeightContainer extends Component {
  componentDidMount() {
    this.props.fetchWeights();
  }

  formatXAxis(tickItem) {
    return moment(tickItem).format('DD/MM/YYYY');
  }

  render() {
    const { classes, weights } = this.props;

    return (
      <div>
        {/*<Button*/}
          {/*className={classes.fab}*/}
          {/*component={Link}*/}
          {/*color="secondary"*/}
          {/*to={`/new`}*/}
          {/*variant="fab"*/}
        {/*>*/}
          {/*<AddIcon />*/}
        {/*</Button>*/}
        <Card className={classes.container}>
          <CardHeader component={() =>
            <Typography
              className={classes.typography}
              variant="title"
              color="inherit"
            >
              {/*<SentimentSatisfied /> Jokes*/}
              Weights
            </Typography>
          } />
          <Paper className={classes.root}>
            <Table className={classes.table}>
              <TableHead>
                <TableRow>
                  <CustomTableCell>Question</CustomTableCell>
                  <CustomTableCell>Answer</CustomTableCell>
                  <CustomTableCell>Actions</CustomTableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {weights.map(joke => {
                  return (
                    <TableRow key={joke.id} className={classes.row}>
                      <CustomTableCell>{joke.date}</CustomTableCell>
                      <CustomTableCell>{joke.value}</CustomTableCell>
                      <CustomTableCell>
                        {/*<Button*/}
                          {/*component={Link}*/}
                          {/*to={`/${joke.id}`}*/}
                        {/*>*/}
                          {/*<EditIcon />*/}
                        {/*</Button>*/}
                        {/*<Button onClick={() => this.handleOpenDialog(joke.id)}>*/}
                          {/*<DeleteIcon />*/}
                        {/*</Button>*/}
                      </CustomTableCell>
                    </TableRow>
                  )
                })}
              </TableBody>
              <TableFooter>
                <TableRow>
                  {/*<TablePagination*/}
                    {/*colSpan={3}*/}
                    {/*count={jokes.length}*/}
                    {/*rowsPerPage={rowsPerPage}*/}
                    {/*page={page}*/}
                    {/*onChangePage={this.handleChangePage}*/}
                    {/*onChangeRowsPerPage={this.handleChangeRowsPerPage}*/}
                    {/*ActionsComponent={TablePaginationActions}*/}
                  {/*/>*/}
                </TableRow>
              </TableFooter>
            </Table>
            {/*<ConfirmationDialogRaw*/}
              {/*classes={{*/}
                {/*paper: classes.paper*/}
              {/*}}*/}
              {/*open={this.state.openDialog}*/}
              {/*onClose={this.handleCloseDialog}*/}
            {/*/>*/}
          </Paper>
        </Card>
      </div>
    );
  }
}

WeightContainer.propTypes = propTypes

const mapStateToProps = state => ({
  weights: state.dashboard.weights
});

export default connect(mapStateToProps, {
  fetchWeights
})(withStyles(styles)(WeightContainer))
