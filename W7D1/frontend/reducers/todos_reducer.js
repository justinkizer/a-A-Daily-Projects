import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from "../actions/todo_actions.js";
import { merge } from 'lodash';

const initialState = {
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
};

export default (state = initialState, action) => {
  Object.freeze(state);
  switch(action.type){
    case RECEIVE_TODOS:
      const newState = {};
      action.todos.forEach( todo => {
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      let newTodo = {};
      newTodo[action.todo.id] = action.todo;
      return merge(newTodo, state);
    case REMOVE_TODO:
      let nextState = merge({}, state);
      delete nextState[action.todo.id];
      return nextState;
    default:
      return state;
  }
};
