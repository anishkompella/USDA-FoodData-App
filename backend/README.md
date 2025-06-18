# Backend Documentation



## Running the App 
0. Environment Setup: Be sure you have the following installed on your local machine
Visual Studio Code
Python 3
Git

1. Install Neccessary Libraries/Dependencies: These will be specified in requirements.txt file

2. Git Clone: Clone this repository into your local maching using this command:
[text](https://github.com/anishkompella/USDA-FoodData-App.git)

3. Terminal Setup: Start a new terminal and run:
[text](uvicorn main:app --reload)

4. Flutter: cd into the frontend directory and this command:
[text](flutter run)

5. Try a simulator: If you are on Mac, you can explore the app on an IOS simulator, otherwise try a browser


## Endpoints

This application makes use of 2 endpoints:

When running locally the base URL will be http://<your-server-host>:8000

The search endpoint traverses the data for food's matching the query and returns all that do. It can be called using GET /foods/search
Usage examples: curl "http://localhost:8000/foods/search?query=Cheddar%20Cheese&pageSize=20"

Successful Response(200 OK)
[text](

{
  "foodSearchCriteria": {
    "query": "Cheddar cheese",
    "dataType": [
      "Foundation",
      "SR Legacy"
    ],
    "pageSize": 25,
    "pageNumber": 2,
    "sortBy": "dataType.keyword",
    "sortOrder": "asc",
    "brandOwner": "Kar Nut Products Company",
    "tradeChannel": [
      "“CHILD_NUTRITION_FOOD_PROGRAMS”",
      "“GROCERY”"
    ],
    "startDate": "2021-01-01",
    "endDate": "2021-12-30"
  },
  "totalHits": 1034,
  "currentPage": 0,
  "totalPages": 0,
  "foods": [
    {
      "fdcId": 45001529,
      "dataType": "Branded",
      "description": "BROCCOLI",
      "foodCode": "string",
      "foodNutrients": [
        {
          "number": 303,
          "name": "Iron, Fe",
          "amount": 0.53,
          "unitName": "mg",
          "derivationCode": "LCCD",
          "derivationDescription": "Calculated from a daily value percentage per serving size measure"
        }
      ],
      "publicationDate": "4/1/2019",
      "scientificName": "string",
      "brandOwner": "Supervalu, Inc.",
      "gtinUpc": "041303020937",
      "ingredients": "string",
      "ndbNumber": 0,
      "additionalDescriptions": "Coon; sharp cheese; Tillamook; Hoop; Pioneer; New York; Wisconsin; Longhorn",
      "allHighlightFields": "string",
      "score": 0
    }
  ]
}
)

The second endpoint uses GET /food/{fdcId} to find key nutrient details for a given food ID
Usage example: curl "http://localhost:8000/food/534358"

Successful Response(200 OK)
[text](
{
  "dataType": "Branded",
  "description": "NUT 'N BERRY MIX",
  "fdcId": 534358,
  "foodNutrients": [
    {
      "number": 303,
      "name": "Iron, Fe",
      "amount": 0.53,
      "unitName": "mg",
      "derivationCode": "LCCD",
      "derivationDescription": "Calculated from a daily value percentage per serving size measure"
    }
  ],
  "publicationDate": "4/1/2019",
  "brandOwner": "Kar Nut Products Company",
  "gtinUpc": "077034085228",
  "ndbNumber": 7954,
  "foodCode": "27415110"
}
)

## Error Handling:

Validation Errors (400): Automatically returned by FastAPI when query or path parameters fail type/constraint checks. Response body follows the standard FastAPI error schema with a list of issues under detail.

Upstream/API Errors (502): When the call to the USDA API fails, it is caught and returns 502 Bad Gateway with the error message in detail.

Unhandled Exceptions (500): Any other server error will return a 500 response
