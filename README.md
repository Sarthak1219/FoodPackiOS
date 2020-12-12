# FoodPackiOS
The FoodPack program idea is a system where restuarants can request pickup for excess food to be delivered to nearby partner organizations, such as Food Pantries, Food Banks, etc.

This FoodPack iOS App for Volunteers in FoodPack Program allows them to see restaurants with pending requests, view route and pickup information, and accept requests.

The app gets data from our MySQL DataBase -using a PHP script- containing information about Restaurants, including location and inventory message. 

The Home screen shows a list of all Restaurants with toggle for displaying all or just those waiting for pickup (Red is ready for pickup, Gray is not).

<img src="/FoodPackiOS/Github%20Images/Home%20Screen.png" alt="Home Screen View" width="175" height="400">

Clicking a restaurant on the home screen opens a detailed view of the Restaurant's location and route information, inventory and notice messages for the volunteer, and a button to accept the request.

Map View | Map View with Panel Showing
------------ | -------------
<img src="/FoodPackiOS/Github%20Images/Single%20Restaurant.png" alt="Single Restaurant View" width="175" height="400"> | <img src="/FoodPackiOS/Github%20Images/Single%20Restaurant%20with%20Panel.png" alt="Single Restaurant w/ PanelView" width="175" height="400">
