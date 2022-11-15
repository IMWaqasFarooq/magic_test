# magic_test

Assignment Flutter project for MAGIC

## Getting Started

This project is a starting point for a Flutter application.

I didnt use any state management package because that was small project and have few states only, 
but i have experience in BLoC state management and i am using it with my current role to manage states,
i prefer Bloc over other state management packages because through Bloc you can easily separate business logic from UI,
and also its simple and easily testable, yes it contains a lot of boilerplate but its does not matter for big projects
because its also help you make clear code structure 

i use hive to store objects locally, because hive is fast and best for storing objects and lists if you dont require complex
relational data, i use hive generator and build value to generate states for data model and create model adapter,

i use mockito for unit test to mock the classes and not access real data.
