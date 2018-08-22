import {
  Card,
  CardHeader,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableFooter,
  TableHead,
  TableRow,
  Typography
} from '@material-ui/core'
import { withStyles } from '@material-ui/core/styles/index'
import moment from 'moment'
import PropTypes from 'prop-types'
import React, { Component } from 'react'
import Moment from 'react-moment'
import { connect } from 'react-redux'
import { fetchWeights } from '../../actions/weightActions'
import { styles } from './styles'

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
  classes: PropTypes.object.isRequired
}

class WeightContainer extends Component {
  componentDidMount() {
    this.props.fetchWeights()
  }

  formatXAxis(tickItem) {
    return moment(tickItem).format('DD/MM/YYYY')
  }

  render() {
    const { classes, weights } = this.props

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
                  <CustomTableCell>Data</CustomTableCell>
                  <CustomTableCell>Valor</CustomTableCell>
                  {/*<CustomTableCell>Actions</CustomTableCell>*/}
                </TableRow>
              </TableHead>
              <TableBody>
                {weights.map(weight =>
                  <TableRow key={weight.id} className={classes.row}>
                    <CustomTableCell>
                      <Moment format="DD/MM/YYYY HH:mm">
                        {weight.date}
                      </Moment>
                    </CustomTableCell>
                    <CustomTableCell>{weight.value}</CustomTableCell>
                    {/*<CustomTableCell>*/}
                    {/*<Button*/}
                    {/*component={Link}*/}
                    {/*to={`/${joke.id}`}*/}
                    {/*>*/}
                    {/*<EditIcon />*/}
                    {/*</Button>*/}
                    {/*<Button onClick={() => this.handleOpenDialog(joke.id)}>*/}
                    {/*<DeleteIcon />*/}
                    {/*</Button>*/}
                    {/*</CustomTableCell>*/}
                  </TableRow>
                )}
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
    )
  }
}

WeightContainer.propTypes = propTypes

const mapStateToProps = state => ({
  weights: state.weights.data
})

export default connect(mapStateToProps, {
  fetchWeights
})(withStyles(styles)(WeightContainer))
