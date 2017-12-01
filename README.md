# The Enotspac

This API is designed to support the Smart-Shop application for reuse over the internet. It allows users to create and manage accounts as well as their lists and list items and items.

The API sanitizes request per user but does not validate naming and prior presence of items.

## Deployment
The production database is hosted by Heroku at https://fast-stream-81519.herokuapp.com/.

## Technologies used
API is written with Rails, utilizing the standard ActiveRecord, Ruby, along with custom routing and serialization.

## Authentication API
Authentication of the user actions comes from the User API controller. This object was provided, and follows the provided methods.

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| DELETE | `/sign-out/:id`        | `users#signout`   |
| PATCH  | `/change-password/:id` | `users#changepw`  |


## UserProfile API
The UserProfile API handles all UserProfile actions, and includes create and read actions for the user's user_profiles. This controller inherits from ProtectedController. No unauthenticated actions are available.

All actions must include an Authentication token in the header. Requests not including an authentication token will have a response of Access Denied.

No data required. 

UserProfile calls expect a user ID. Post request will automatically create the UserProfile for the authentication user. A successful request will include the UserProfile, Explorations, Creatures and Encounters. Get request recalculates energy available based on time.

UserProfile creation is automatically performed on user sign-up. A post will recreate the profile and reset to base values.

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/user_profiles/`      | `user_profiles#create`    |
| GET    | `/user_profiles/:id`   | `user_profiles#show`      |


## Levels API
The Levels API returns the index of levels or an individual level by level not id.

All actions must include an Authentication token in the header. Requests not including an authentication token will have a response of Access Denied.

No data required. 


| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| GET   | `/levels/`      | `levels#create`    |
| GET    | `/levels/:id`   | `levels#show`      |

## Exploration API
The Exploration API handles all explorations and battle actions, and implements create, read, and destroy without query values, and update actions with query parameters.

All actions will result in the current exploration on success, or bad request response and the given error, or 'Insufficient energy' if not enough energy is available.
All actions must include an Authentication token in the header. Requests not including an authentication token will have a response of Access Denied.

`Update | /explorations/:id?start | explorations#update`<br>
This request handles the intitial area actions. Data format is 
```js
"exploration": {
  "area": Desert|Forest|Mountain|Plains,
  "diff": desired difficulty
}
```
Area will be evaluated internally and must match an available area. Difficulty must be equal to or less than the associated top value (top_d = Highest available Desert exploration).
Invalid requests will return bad request as well as 'Invalid area argument'

`Update | /explorations/:id?move | explorations#update`<br>
This request handles the movement through areas. Data format is 
```js
"exploration": {
  "area": current area,
  "diff": current difficulty
}
```
Movement will be evaluated internally, as well as encounter creation on a randomly generated basis. Move request is not available during an encounter or if an area has not been started.

A valid request will return the current exploration and any

Invalid requests will return bad request as well as 'Move action not valid at this time'

`Update | /explorations/:id?attack | explorations#update`<br>
This request handles the encounters. Data format is 
```js
"exploration": {
  "area": current area,
  "diff": current difficulty
}
```
Battle resolution is handled internally. Attack actions may 'miss' and will return the current encounter as well as the exploration. If the battle is the exploration end battle, experience, items and gold will be applied to the user profile as well as leveling logic. Exploration will be reset to accept a new start request. 

Exploration creation is automatically performed on user sign-up. A post will recreate the exploration and reset to base values.

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/explorations`               | `explorations#index`     |
| GET    | `/explorations/:id`      | `explorations#show`   |
| Update    | `/explorations/:id?start`           | `explorations#update`      |
| Update    | `/explorations/:id?move`    | `explorations#update`    |
| Update | `/exploration/:id?attack`           | `exploration#update`    |
| DELETE | `/exploration/:id`      | `exploration#destroy`|

## Creatures API
The Creature API handles creature requests, and implements create, read, and destroy without query values, and update actions with query parameters.

All actions will result creature on success, or bad request response and the given error if an error or invalid request is made.
All actions must include an Authentication token in the header. Requests not including an authentication token will have a response of Access Denied.

`Update | /creatures/:id | creatures#update`<br>
```js
"creature": {
  "area": c_hp|c_def|c_dex|c_str|c_spd|c_str|c_int,
  "diff": amount to increase
}
```
Adds the requested amount to the requested stat if points are available. Only one stat can be updated at a time. If multiple stats are requested, response will be 'Invalid argument count' and a bad request. If the status cannot be improved because it will exceed the maximum, the response will be 'Cannot exceed maximum value' and bad request. If there are not enough points available to increase, the response will be 'Insufficient available to increase' and bad request. A successful request will result in the creature object. 

`Update | /creatures/:id?evolve | creatures#update`<br>
Evolves the creature if all stats are at their current maximum. An invalid request will result in 'Cannot evolve at this time' and bad request. Successful requests will include the updated creature object.

Creature creation is automatically performed on user sign-up. A post will recreate the creature and reset to base values.

| Verb   | URI Pattern            | Controller#Action   |
|--------|------------------------|---------------------|
| POST   | `/creatures`          | `creatures#create` |
| GET    | `/creatures/:id`      | `creatures#show`   |
| PATCH  | `/creatures/:id`      | `creatures#update` |
| PATCH  | `/creatures/:id?evolve`      | `creatures#update` |
| DELETE | `/creatures/:id`      | `creatures#destroy`|



## The Front End.
The Front End can be found here, [Front End Repository](https://github.com/BrianLM/capstone-client). The production site is at [Enotspac](https://brianlm.github.io/capstone-client/home)

## ERD
![ERD](https://github.com/BrianLM/capstone-api/blob/master/erd.png)
