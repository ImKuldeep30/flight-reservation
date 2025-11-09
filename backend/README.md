Basic Flight Reservation backend

This is a minimal backend implementing authentication, flights, seats, bookings and payments using MySQL.

Environment
- DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD - database connection
- PORT - server port
- SECRET - JWT secret

Quick start
1. Install dependencies:

```
cd backend
npm install
```

2. Create the database and tables. You can use the SQL in `db/schema.sql`.

3. Run the server (example using PowerShell):

```
$env:DB_HOST='localhost'; $env:DB_DATABASE='flight_reservation'; $env:DB_USER='root'; $env:DB_PASSWORD='yourpass'; $env:PORT=3000; $env:SECRET='change-me'; npm start
```

Endpoints (examples)
- POST /auth/register { name, email, phone, password }
- POST /auth/login { email, password } -> returns { token }
- GET /flights
- GET /flights/:id
- GET /seats/flight/:flightId
- POST /bookings (auth required) { flight_id, passengers: [{name, age, gender, seat_id?}] }
- POST /payments (auth required) { booking_id, amount, method }

Notes / next steps
- Add more validation and error handling
- Use DB migrations (eg. knex/umzug) and proper seeding
- Protect admin endpoints and add role-based checks
# backend

## Setup

1. Go to project folder

> cd backend

2. Install Dependencies

> npm run setup

3. Create .env with following content

````
DB_HOST=
DB_DATABASE=
DB_USER=
DB_PASSWORD=

PORT=3000
SECRET=AAA
````

## Run

1. Start Server

> npm start

2. Open in url or using an Endpoint tester (postman)

> http://127.0.0.1:3000/