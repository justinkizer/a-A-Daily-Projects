import React from 'react';
import { uniqueId } from '../../util/idGenerator';

export class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {title: "", body: "", done: false};

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(property) {
   return e => this.setState({[property]: e.target.value});
  }

  handleSubmit(event) {
    event.preventDefault();
    const todo = Object.assign({}, this.state, { id: uniqueId() });
    this.props.receiveTodo(todo);
    this.setState({
      title: "",
      body: ""
    });
  }


  render() {
    return (
    <form onSubmit={this.handleSubmit}>
      <label>
        Title:
        <input type="text" onChange={this.update("title")} value={this.state.title} />
      </label>
      <label>
        Body:
        <input type="text" onChange={this.update("body")} value={this.state.body} />
      </label>
      <label>
        Done:
        <input type="checkbox" value={this.state.done} />
      </label>
      <button className="create-button">Create Todo!</button>
  
    </form>
  );}

}
