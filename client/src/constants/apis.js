export const ROOT_URL = process.env.NODE_ENV === 'production'
  ? process.env.REACT_APP_ROOT_URL || 'https://saudecontrolada.herokuapp.com'
  : process.env.REACT_APP_ROOT_URL || 'http://localhost:3000'
