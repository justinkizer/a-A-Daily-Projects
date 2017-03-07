import React from 'react';
import TodoListItem from './todo_list_item.jsx';
import { TodoForm } from './todo_form.jsx';

const TodoList = ({todos, receiveTodo, removeTodo}) => {
  return (
  <div>
    <ul>
      {
        Object.keys(todos).map((key) => (
          <div>
          <TodoListItem key={key} todo={todos[key]}></TodoListItem>
          <button key={`${key}-button`}
            className="delete-button"
            onClick={ removeTodo }>Delete Todo</button>
          </div>
        ))
      }
    </ul>
    <TodoForm removeTodo={removeTodo} receiveTodo={ receiveTodo }/>
  </div>
);
};


export default TodoList;
