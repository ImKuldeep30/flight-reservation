# Flight Reservation Backend — API Documentation

Base URL: http://localhost:PORT (PORT from environment)

Authentication: JWT bearer token signed with `process.env.SECRET` (set in environment). Protected endpoints require the header:

Authorization: Bearer <token>

----

## Authentication

### POST /auth/register
- Purpose: Create a new user
- Request JSON body:
  - name (string) — required
  - email (string) — required
  - phone (string) — optional
  - password (string) — required
- Responses:
  - 201: { status: true, user: { user_id, name, email, phone } }
  - 400: { status: false, message: 'Missing required fields', missing: [ ... ] }
  - 409: { status: false, message: 'Email already registered' }

Example (curl):
```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com","password":"Secret123"}'
```

### POST /auth/login
- Purpose: Authenticate user and return JWT
- Request JSON body:
  - email (string) — required
  - password (string) — required
- Responses:
  - 200: { status: true, token: "<JWT>" }
  - 400: { status: false, message: 'email and password required' }
  - 401: { status: false, message: 'Invalid credentials' }

Example (curl):
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"alice@example.com","password":"Secret123"}'
```

----

## Flights

### GET /flights/
- Purpose: List flights
- Query params: (none defined in routes) — server may support optional filtering in controller
- Responses:
  - 200: JSON array of flight objects

### GET /flights/:id
- Purpose: Get flight details by id
- Path params:
  - id (number) — flight id
- Responses:
  - 200: flight object
  - 404: { status: false, message: 'Not found' } (controller behavior)

### GET /flights/upcoming
- Purpose: List all upcoming flights for today (from now) and tomorrow
- Query params: (none)
- Responses:
  - 200: { status: true, flights: [ { ...flight fields..., departure_airport, departure_code, arrival_airport, arrival_code, total_seats }, ... ] }
  - 500: { status: false, message: 'Internal server error' }

Example (curl):
```bash
curl http://localhost:3000/flights/upcoming
```

----

## Seats

### GET /seats/flight/:flightId
- Purpose: List seats for a given flight
- Path params:
  - flightId (number) — flight id
- Responses:
  - 200: JSON array of seat objects

----

## Bookings (Authenticated)

All booking endpoints require authentication (Authorization: Bearer <token>) via `auth.middleware`.

### POST /bookings/
- Purpose: Create a new booking for the authenticated user
- Request JSON body (controller defines exact fields; typically):
  - flight_id (number)
  - seat_id (number)
  - payment_method (string) or payment details
- Responses:
  - 201: { status: true, booking: { ... } }
  - 400/422: validation errors
  - 401: when token missing/invalid

Example (curl):
```bash
curl -X POST http://localhost:3000/bookings \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"flight_id":1,"seat_id":10}'
```

### POST /bookings/:id/cancel
- Purpose: Cancel a booking (authenticated)
- Path params:
  - id (number) — booking id
- Responses:
  - 200: { status: true, message: 'Cancelled' }
  - 401: unauthorized
  - 404: booking not found

----

## Payments (Authenticated)

### POST /payments/
- Purpose: Create a payment record (authenticated)
- Request JSON body (controller determines fields):
  - booking_id (number)
  - amount (number)
  - method (string)
- Responses:
  - 201: { status: true, payment: { ... } }
  - 400/422: validation errors
  - 401: unauthorized

----

## Notes & Next Steps
- The route files describe URL structure and HTTP methods; check controllers for exact request/response fields and error shapes.
- The server requires the following environment variables (enforced by `mandatoryenv`):
  - DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD, PORT, SECRET
- Security:
  - Set a strong `SECRET` in production; do not use the default `change-me`.
  - Consider adding rate-limiting on authentication endpoints.

If you'd like, I can:
- Generate a Postman / OpenAPI (Swagger) spec from these routes.

## Admin Panel

Base path: /adminPanel (admin-only — requires Authorization: Bearer <JWT> and the user role must be `admin`)

### Flight Management (Admin)

All endpoints under `/adminPanel/flights` require an admin JWT.

POST /adminPanel/flights
- Purpose: Create a new flight
- Request JSON body (required):
  - flight_number (string)
  - aircraft_id (number)
  - departure_airport_id (number)
  - arrival_airport_id (number)
  - departure_time (datetime string)
  - arrival_time (datetime string)
  - base_fare (number)
  - airline (string) — optional
- Responses:
  - 201: { status: true, flight: { ... } }
  - 400: validation errors

GET /adminPanel/flights
- Purpose: List flights (paginated + filterable)
- Query params:
  - page (number, default 1)
  - limit (number, default 20)
  - airport_id (number) — filter by origin or destination
  - date (YYYY-MM-DD) — filter departure date
  - min_price, max_price
  - airline
  - includeDeleted=true — include soft-deleted flights
- Responses:
  - 200: { status: true, total, page, limit, flights: [ ... ] }

GET /adminPanel/flights/:id
- Purpose: Fetch single flight details (admin view)
- Responses:
  - 200: { status: true, flight }
  - 404: not found

PATCH /adminPanel/flights/:id
- Purpose: Update flight fields safely. Only certain fields are allowed: flight_number, aircraft_id, departure_airport_id, arrival_airport_id, departure_time, arrival_time, base_fare
- Notes: If updating `aircraft_id`, the service checks existing booked passengers and rejects the update if the new aircraft has fewer seats than already booked passengers.

DELETE /adminPanel/flights/:id
- Purpose: Soft-delete a flight by default (sets `is_deleted`). To hard-delete permanently use `?hard=true`.

### Analytics

GET /adminPanel/analytics/revenue?year=2025
- Purpose: Return month-wise revenue for the provided year (defaults to current year). Revenue is aggregated from successful payments.
- Responses:
  - 200: { status: true, year: 2025, revenue: [ { month: 1, revenue: 123.45 }, ... ] }

