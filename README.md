# An elixir app for demonstrating JSONAPI (JaSerializer) with Phoenix

## Set up
```
psql postgres
CREATE USER postgres SUPERUSER;

mix deps.get
mix ecto.create
mix ecto.migrate

mix run priv/repo/seeds.exs
```

## To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Example Queries

### JSONAPI Queries
* [x] http://localhost:4000/api/users
* [x] http://localhost:4000/api/users?page[page_number]=10
* [x] http://localhost:4000/api/users?page[page_number]=10&page[page_size]=1000
* [x] http://localhost:4000/api/users?page[page_number]=10&page[page_size]=1000&fields[users]=email
* [x] http://localhost:4000/api/users?page[page_number]=10&page[page_size]=1000&fields[users]=email&include=teams
* [x] http://localhost:4000/api/users?page[page_number]=10&page[page_size]=1000&fields[users]=email&include=teams&fields[teams]=name

### Download all users
```bash
curl -X GET -H "Accept: application/vnd.api+json" -H "Cache-Control: no-cache" -H "Postman-Token: 0b58cf44-dc23-578e-7ed2-c4dcab7ed87a" "http://localhost:4000/api/users?page%5Bpage_size%5D=100000" -o users.html
```

### List users and team names
```sql
SELECT
  email, teams.name
FROM
  users
    LEFT JOIN teams_users ON teams_users.user_id = users.id
    INNER JOIN teams ON teams_users.team_id = teams.id
ORDER BY email;
```
