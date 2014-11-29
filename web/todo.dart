//https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:html
import 'dart:html';


InputElement newTaskInput;
UListElement taskList;


void main() {
  newTaskInput = querySelector("#newTaskInput");
  taskList = querySelector("#tasks");
  
  querySelector("#newTaskInput").onChange.listen(addTask);
}


void addTask(Event e) {
  String taskName = (e.target as InputElement).value;
  var newTask = new Element.tag('li');
  newTask.className = 'todo-list-item';
  newTask.text = taskName;
  /*var newTask = new Element.html(
      '<li class="todo-list-item">'+
        '<span>'+ taskName + '</span>'+
        '<ol class="todo-buttons"><li>&#10004;</li><li>&#10008;</li></ol>'+
      '</li>');
  newTask.onClick.listen((e) => newTask.remove());*/
  
  var newOl = new Element.tag('ol');
  newOl.className = 'todo-buttons';
  var done = new Element.tag('li');
  done.nodes.add(new DocumentFragment.html('&#10004;'));
  var cancel = new Element.tag('li');
  cancel.nodes.add(new DocumentFragment.html('&#10008;'));
  
  newOl.append(done);
  newOl.append(cancel);
  newTask.append(newOl);
  
  cancel.onClick.listen((e) => newTask.remove());
  done.onClick.listen(completeTask);
  
  newTaskInput.value = '';
  taskList.children.add(newTask);
}

void completeTask(Event e) {
  var doneButton = e.target as LIElement;
  var currentTask = findClosestAncestor(doneButton, 'li');
  doneButton.remove();
  currentTask.classes.add('done');
}

// http://stackoverflow.com/questions/16445976/is-there-an-equivalent-to-jquerys-closest-in-dart
Element findClosestAncestor(element, ancestorTagName) {
  Element parent = element.parent;
  while (parent.tagName.toLowerCase() != ancestorTagName.toLowerCase()) {
    parent = parent.parent;
    if (parent == null) {
      // Throw, or find some other way to handle the tagName not being found.
      throw '$ancestorTagName not found';
    }
  }
  return parent;
}