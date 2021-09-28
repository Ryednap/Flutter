# Todo Application

## Intro

This a probably very simple todo application but very recommended for someone just beginning with flutter.
It involves most of the basic widgets along with basics of state management in flutter with provider package.
How to creater flutter_slidable, and dynamic dashboard based on user input in bottom-navBar. Apart from this it also involves basics of Form building, Alert Dialog creating and how to pass callback functions to descendents in flutter.

## File Info and Dependency Structure

* **main.dart :** main file of the application, defines the main function which builds a material widget wrapped with changeNotifierProvider which provides the instance of TodosProvider class from todos_provider.dart to all the descendents. (Read more about ChangeNotifierProvider and state managment here)

* **home_page.dart :**  The main page of the  application which is built on Scaffold widget with appbar, body, bottomnav-bar and a floating button. In the bottomnav-bar we have two items the **todo** and **completed todo** which on selecting get's reflected in body part between **TodoWrapper** and **CompletedPage**.This process utilizes ephemeral state **_index**. Moreover, the Floating Action button is used to call the TodoDialog class from todo_dialog.dart.

* **todo_dialog.dart :** Providers AlertDialog Widget to be rendered in homepage. It takes the help of another class TodoForm from todo_form.dart page to create the form and for the callbacks to the formfield it passes the callback function to TodoForm. Basically we need 3 tasks, **add_title**,**add_descripton** and **onSave** feature which on saving adds a new Todo item in the TodosProvider list *(defined in todos_provider.dart)*, hence here we user provider to accomplish the task of adding.

* **Todo_wrapper.dart :**  