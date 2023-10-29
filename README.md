# flutter_challenge

This is a  test project build using Flutter and MVVM architecture(using provider for state management and get_it for dependency injection and service locator)

## Getting Started
To run the project run *flutter run* or *make run* on the root of your project

## The  unit test is located in test folder and the integration test is located in integration_test folder

To run the e2e test run *flutter test integration_test* or *make integration_test* (via makefile)

To run the unit test run *flutter test test/unit_test.dart* 


## MVVM architectural style used
1. Model (model folder)
The Model represents the data and the business logic of the application. It is responsible for fetching, processing, and managing data. In the MVVM pattern, the Model encapsulates the data and exposes it to the ViewModel. It should not have any direct knowledge of the user interface

2. View/UI 
The View is the visible part of the application that the user interacts with. It's responsible for rendering the user interface and displaying data. Unlike traditional architectures like MVC (Model-View-Controller), the View in MVVM is passive and contains as little logic as possible. Its primary role is to bind to the ViewModel and reflect the data and user interactions

3. Viewmodel (viewmodel folder)
The ViewModel acts as an intermediary between the Model and the View. It transforms the data from the Model into a format that can be easily displayed by the View. The ViewModel contains the presentation logic, which includes formatting, validation, and handling user input. It also manages the state and behavior of the UI components. The key feature of the ViewModel is its ability to notify the View of changes in the data, typically through data-binding mechanisms

4. Repository (repository folder)
 The central element of the pattern, the repository, acts as an intermediary between the application's business logic and the data source. It abstracts the data access code and provides a set of methods that the application uses to interact with the data source. 

5. Dependency Injection (di file)
 Dependency Injection is a design pattern that promotes the idea of "inverting the control" of object creation and management


6. Service Locator (getIt)
Service Locator is a design pattern that provides a centralized registry (the "Service Locator") for managing and accessing services and dependencies




