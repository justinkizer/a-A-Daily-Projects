import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer.js';

export const configureStore = () => (
  createStore(rootReducer)
);
