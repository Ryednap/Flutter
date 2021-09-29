# Todo Application

## Intro

This a probably very simple todo application but very recommended for someone just beginning with flutter.
It involves most of the basic widgets along with basics of state management in flutter with provider package.
How to creater flutter_slidable, and dynamic dashboard based on user input in bottom-navBar. Apart from this it also involves basics of Form building, Alert Dialog creating and how to pass callback functions to descendents in flutter.

## File Info and Dependency Structure

![alt text](https://github.com/Ryednap/Flutter/blob/dev/todo//extras/todo_tree_structure.jpg?raw=true)

* **main.dart :** main file of the application, defines the main function which builds a material widget wrapped with changeNotifierProvider which provides the instance of **TodosProvider** class from ***todos_provider.dart*** to all the descendents. (Read more about **ChangeNotifierProvider** and state managment here) [State Management Flutter](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

* **home_page.dart :**  The main page of the  application which is built on Scaffold widget with appbar, body, bottomnav-bar and a floating button. In the bottomnav-bar we have two items the **todo** and **completed todo** which on selecting get's reflected in body part between **TodoWrapper** and **CompletedPage**.This process utilizes ephemeral state **_index**. Moreover, the Floating Action button is used to call the TodoDialog class from todo_dialog.dart.

* **todo_dialog.dart :** Providers **AlertDialog** Widget to be rendered in homepage. It takes the help of another class **TodoForm** from **todo_form.dart** page to create the form and for the callbacks to the formfield it passes the callback function to TodoForm. Basically we need 3 tasks, **add_title**,**add_descripton** and **onSave** feature which on saving adds a new Todo item in the **TodosProvider list *(defined in todos_provider.dart)***, hence here we user provider to accomplish the task of adding.

* **todo_wrapper.dart :**  It's a wrapper widget that takes all the todo items from **TodosProvider** list with the help of provider package and renders each of them in the form of **TodoWidget *(todo_widget.dart)*** in a listview.

* **todo_widget.dart :** defines a single todo widget. Each todo widget is a flutter **Slidable** widget wrapped in a **ClipRRect** to give a cardlike view. **Slidable** defines two types of actions, primary (left when swiped right) and secondary (right when swiped left). Inside which we have and edit Icon to left which takes us to **EditTodoPage** to edit the current todo and a delete icon to delete the todo (just remove the current todo from TodosProvider list) and then in child a simple row and column to display the title and description.

* **completed_page.dart :** Sames as todo_wrapper but it renders only completed (check marked) **TodoWidget**
  
* **todo_model.dart :** defines **TodoModel** class that models the todo properties whose object we need to pass around the application.

* **todo_providers.dart :** :- Inherits the **changeNotifierProvider**. Defines the list of **TodoModel** to store the todo's created. also defines getter and setters. It's a kind of bradcaster that broadcast it's data.

* **color_pallete.dart :** :- Define Custom Material Color pallette.

## In app Screenshots

![alt text](https://github.com/Ryednap/Flutter/blob/dev/todo/no_todos.jpeg?raw=true)
![alt text](https://github.com/Ryednap/Flutter/blob/dev/todo/completed.jpeg?raw=true)
![alt text](https://github.com/Ryednap/Flutter/blob/dev/todo/task_complete.jpeg?raw=true)
![alt text](https://github.com/Ryednap/Flutter/blob/dev/todo/demo.gif?raw=true)