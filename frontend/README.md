# Features
Search Screen
Text input for food names
Tap an item to view its nutrients
Displays key nutrients in a table form
Forward/back navigation between search and detail screens


# Running the App 
0. Environment Setup: Be sure you have the following installed on your local machine
Visual Studio Code
Python 3
Git

1. Install Neccessary Libraries/Dependencies: These will be specified in requirements.txt file

2. Git Clone: Clone this repository into your local maching using this command:
https://github.com/anishkompella/USDA-FoodData-App.git

3. Terminal Setup: Start a new terminal and run:
uvicorn main:app --reload

4. Flutter: cd into the frontend directory and this command:
flutter run

5. Try a simulator: If you are on Mac, you can explore the app on an IOS simulator, otherwise try a browser
IOS
flutter run -d ios
Web 
flutter run -d chrome


# API Integration
HTTP client defined in lib/services/api.dart

Two main calls:

searchFoods(query, pageSize, pageNumber) → returns SearchResponse

fetchFoodDetail(fdcId) → returns FoodDetail

Parses JSON into PODOs in lib/models/

