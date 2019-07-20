# Test Assignment

A single-view app for displaying a list of countries from Countries REST API: [https://restcountries.eu/](https://restcountries.eu/)

The app has pre-defined screen structure, networking and data access layers in place.

The task is to complete the app by implementing the UI, connecting it with the data access layer and writing unit tests.

In your implementation, you need to aim for the best code quality by following the best practices and standards established in the industry.

# Requirements

The UI of the app doesn't have to look pretty, but needs to function according to the specification:

* When the app launches, it should indicate the process of loading the list of countries.
* If an error occurs, its description should be displayed to the user along with an option to recover from the error.
* For each loaded country from the list the app should display country's name, its capital and the list of national currencies.
* The list of countries is paginated. The app should load additional pages one at a time when the user scrolls to the end of the list. The loading process should be indicated to the user.

The UI should be supplemented with minimal, but sufficient set of unit tests that verify its correct behavior based on data access layer updates.

The source file `CountriesService.swift` is not meant to be changed.