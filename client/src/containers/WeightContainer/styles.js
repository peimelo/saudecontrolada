export const styles = theme => ({
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
    right: theme.spacing.unit * 2
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
