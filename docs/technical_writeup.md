#Technical Specifications

For this project, I built a two-part food-nutrition explorer: a Fast API that makes requests to the USDA FDC API, and a Flutter-based frontend that lets users search for foods and view detailed nutrient tables. 

The backend defines two endpoints in the main.py file: 
- GET /foods/search?query=… : forwards the search term to https://api.nal.usda.gov/fdc/v1/foods/search and returns the JSON.

- GET /food/{fdcId} : fetches full nutrient data for a selected food ID.

I have also added CORS middleware to allow the FLutter app to call these endpoints. 

I split the frontend development into multiple componenets. I defined model classes(SearchItem, FoodDetail, FoodNutrient) with fromJson factories to convert raw JSON data into deserialized Dart objects. 

I then used an Api service to handle http calls via the http package. To implement appropriate state-management, I used providers called SearchProvider and DetailProvider to manage search results and nutrient details, loading state, errors, and notifiying widets on changes. 

I then used a Search Screen to display a search bar, error messages, and a scrollable list of results.

The Nutrients Screen uses a FutureBuilder to fetch details for a tapped item, and displays them in a DataTable.

One major challenge I faced during this project was JSON Structure & Null Safety. The USDA API nests nutrient info inside multiple layers and sometimes omits specific fields. To avoid runtime errors, I used Dart's null-safety operators to map null values to appropriate default values.

Another challenge I faced was implementing pagination. In the current implementation the Search Screen extends a Stateless Widget which did not allow for my implementations of the NumberPaginator class. 

Some potential improvements I would like to make to this product before production deployment include moving the API key out of .env and into a secure secrets manager. I would also like to implement a cahcing mechanism to store recent searches. Additionally, I would like to figure out an optmial pagination mechanism for the Search Screen.
