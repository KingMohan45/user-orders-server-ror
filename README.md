### User Orders Management Platform APIs
- `make seed-users` Validates and adds users, products and orders to the database
  - Removed few users and updated emails in users.csv which are duplicates and few with invalid/missing emails
  - Here users's email is unique but not phone number
  - Removed few orders, orders.csv with missing products
    - john.doe@example.com,P011,2024-02-28
    - lily.parker@example.com,P019,2023-12-25
    - olivia.perez@example.com,P050,2024-01-25

### To Start
- Requires RUBY_VERSION=3.3.0 and rails "~> 7.1.3", ">= 7.1.3.2"
- `make install` Installs the dependencies
- `make setup` Sets run migrations and seeds the database
  - `make seed` Seeds the database
- `make start` Starts the server
- Instead `docker-compose build` and `docker-compose up` will bring the service up and running
