import { connect } from "react-redux";
import TodoList from './todo_list.jsx';
import {allTodos} from '../../reducers/selectors.js';
import { receiveTodo, removeTodo } from '../../actions/todo_actions.js';

const mapStateToProps = state => ({
  todos: allTodos(state),
  state
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  receiveTodos: () => dispatch(receiveTodos()),
  removeTodo: (todo) => dispatch(removeTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
