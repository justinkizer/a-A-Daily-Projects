export const allTodos = state => {
  const keys = Object.keys(state.todos);
  const slice = {};
  keys.forEach((el) => {
    slice[el] = state.todos[el];
  });
  return slice;
};
