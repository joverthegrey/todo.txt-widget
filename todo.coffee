command: "/usr/local/bin/todo.sh -p -+ list"
refreshFrequency: 100000

style: """
  top: 30px
  left: 30px
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .4)
  padding 10px 10px 5px
  border-radius 8px
  width: 400px

  .container
    position: relative
    clear: both

  .list
    padding-top: 3px
    width=100%

  .list-item
    font-size: 12px
    font-weight: bold
    color: #fff
    text-shadow: 0 1px 1px rgba(#000, .2)

  .prio
    color: red

  .done
    text-decoration: line-through
    color: grey
    font-style: italic

  .widget-title
    font-size: 12px
    font-weight: bold
    color: #fff
    font-size: larger
    border-bottom: solid #fff
"""

render: (output) -> """
  <div class="container"><div class="widget-title">Todos</div><div id="todos" class="list"></div></div>
"""

update: (output, domElement) ->
  domElement.innerHTML =
    "<div class=\"container\"><div class=\"widget-title\">" +
    "Todos</div><div id=\"todos\" class=\"list\"></div></div>"

  todos = output.split('\n')
  list = $(domElement).find("#todos")

  getClass = (todo) ->
    myClass = "list-item"
    regexpDone = /^\d+\sx\s/
    regexpPrio = /^\d+.+\(([A-Z])\)\s/

    myClass = "list-item prio" if todo.match regexpPrio
    myClass = "list-item done" if todo.match regexpDone

    return myClass

  addTodo = (todo) ->
    myclass = getClass todo
    list.append "<div class=\"#{myclass}\">#{todo}</div>"

  if todos.length == 1
    addTodo "Nothing yet"
  else
    for todo, i in todos
      addTodo todo
