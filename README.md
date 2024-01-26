
# Moneybox iOS Technical Challenge

Thank you for taking the time to evaluate my technical assessment.

## Architecture

I used MVC architecture to display the 3 screens in the app.

## Additional features

Aside from the instructions listed in the brief, I also included the following:

- A Log out button to return the user to the Login page.
- Alert pop-ups to guide the user if an error occurs.
- Accessibility Identifiers were added to some of the labels and buttons. This could be used when the Voicover function is switched on, or for UI testing.
- Removed hard-coded font sizes. This allows text labels to increase/decrease depending on a device's dynamic font settings.
- The autolayout settings I applied ensured that if the dynamic font size was increased, text field and button edges would not disappear off any part of the screen.
- Made use of the grey and accent colours in the Assets folder.

## Future changes

If I were to continue developing the app I would make the following changes:

- Potentially convert to SwiftUI. I have experience working with UIKit but more recently I have opted for using SwiftUI in my projects. 
- As the app continued to scale I would convert to an MVVM pattern to allow for easier debugging and testing.
- Add a Localisation file to store all strings, which would make any required changes to the text (copy) much quicker. Initially this would only be an English language file, but further files could be created if the app catered for other languages. 
- I created unit tests for logging in and fetching products, but I would also add tests for increasing the balance and making calls over an unstable network.
- I would add UI tests.
- Further accessibility features could be added, such as allowing the user the option to change the colouring within the app to cater for colour blindness. Although not necessarily applicable to the current version of the app, I would also make any horizontal stacks convert to vertical, scrollable stacks if the dynamic font size increased. This would prevent anything from spilling off the sides of the screen.
- Along with the "Add £10" button, I would also add a field where they could enter a different figure, then add that amount to the balance.

## The Brief

To create a 'light' version of the Moneybox app that will allow existing users to login and check their account balance, as well as viewing their Moneybox savings. 
- To fork this repository to your private repository and implement the solution.
 
### The app should have
- A login screen to allow existing users to sign in
- A screen to show the accounts the user holds, e.g. ISA, GIA
- A screen to show some details of the account, including a simple button to add money to its moneybox.
- The button will add a fixed amount of £10. It should use the `POST /oneoffpayments` endpoint provided, and the account's Moneybox amount would be updated.

A prototype wireframe of all 3 screens is provided as a guideline. You are free to provide additional information if you wish.
![](wireframe.png)

### What we are looking for
 - **Showcase what you can do. It can be a refined UI, or enhanced UX, or use of specific design patterns in the code, or anything that can make the project stand out.**
 - Demonstration of coding style, conventions and patterns.
 - A tidy code organisation.
 - Use of autolayout (preferably UIKit).
 - Implementation of unit tests.
 - Any accessibility feature would be a bonus.
 - The application must run on iOS 13 or later.
 - Any 3rd party library should be integrated using Swift Package Manager.

### API Usage
The Networking methods and Models for requests and responses are ready-made in the Networking module of the project.

#### Base URL & Test User
The base URL for the moneybox sandbox environment is `https://api-test02.moneyboxapp.com/`. </br>
You can log in using the following user:

|  Username          | Password         |
| ------------- | ------------- |
| test+ios2@moneyboxapp.com  | P455word12  |

#### Authentication
You should obtain a bearer token from the Login response, and attach it as an Authorization header for the endpoints. Helper methods in the API/Base folder should be used for that.
(Note: The BearerToken has a sliding expiration of 5 mins).

| Key  |  Value  |
| ------------- | ------------- |
| Authorization |  Bearer TsMWRkbrcu3NGrpf84gi2+pg0iOMVymyKklmkY0oI84= |

#### API Call Hint

```
let dataProvider = DataProvider()
dataProvider.login(request: request, completion: completion)
```
request: Initialize your request model </br>
Completion: Handle your API success and failure cases

## Unit Tests
The MoneyBoxTests folder includes stubbed data to easily mock the responses needed for unit testing

#### Usage Hint
You can create a DataProviderMock class via inject DataProviderLogic protocol </br>
You can mock response in Login.json file like this:
```
StubData.read(file: "Login", callback: completion)
```

### How to Submit your solution:
 - To share your Github repository with the user valerio-bettini.
 - (Optional) Provide a readme in markdown which outlines your solution.

## Good luck!
