# Transportation Management System #
This backend is the foundation for the Transportation Management System (TMS), which is a software system that helps manage transportation operations for businesses. This system handles drivers , trucks , assign truck to driver

## Technologies Used ##
This backend uses the following technologies:

Ruby on Rails 7.0.5
Postgresql 12.1
Redis
JWT 
Docker
Docker compose 
Sidekiq


## How to run ##
1. build the solution 
```
docker compose build
```
2. Configure the environment variables in the `.env` file:
```
DATABASE_HOST=db
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres12
DATABASE_NAME=t_m_s_development
TRUCK_API_KEY=illa-trucks-2023
TRUCK_API_URL=https://dummy/dummy
JWT_SECRET=KFkVR9B04NrydlZC7ananZJwFBCNv52M
REDIS_HOST=redis
SIDEKIQ_DASHBOARD_USERNAME=admin
SIDEKIQ_DASHBOARD_PASSWORD=dummy
```
3. Start the solution:
```
docker compose up
```
4. Access the APIs through http://localhost:3000/

> Note: you can find postman collection


## Features ## 
- Create a new driver account with the given email and password
- Authenticate a driver with the given email and password and return a JWT token
- Return a list of all trucks 
- Assign the current driver to a truck with a given truck ID
- Return a list of all trucks that the current driver is assigned to

## Class Diagram ##
![Alt text](diagrams/image.png)

## Flow Charts ##
- Fetch New Trucks Service
![Alt text](diagrams/fetch_new_trucks_diagram.png)


- Fetch Trucks Worker
![Alt text](diagrams/fetch_trucks_worker_diagram.png)

## Useful Commands ##
```
# lists containers for the given docker compose configuration
docker compose ps

# lists all running containers in Docker engine
docker ps

# access Backend console
docker exec -it transport-management-system-web-1 /bin/bash

# access byebug while calling api
# first run docker ps
# output should be like that
CONTAINER ID   IMAGE                                 COMMAND                  CREATED       STATUS       PORTS                    NAMES
0595644f7502   transport-management-system_sidekiq   "entrypoint.sh bash …"   2 hours ago   Up 2 hours   3000/tcp                 transport-management-system-sidekiq-1
528ec2087bc9   transport-management-system_web       "entrypoint.sh bash …"   2 hours ago   Up 2 hours   0.0.0.0:3000->3000/tcp   transport-management-system-web-1
d1d0d79fd8aa   postgres:12.1                         "docker-entrypoint.s…"   2 hours ago   Up 2 hours   5432/tcp                 transport-management-system-db-1
1ed44417e177   redis:alpine                          "docker-entrypoint.s…"   2 hours ago   Up 2 hours   0.0.0.0:6380->6379/tcp   transport-management-system-redis-1

# take transport-management-system_web  container ID which will be 528ec2087bc9
# Run docker attach 528ec2087bc9 


```
## Testing using RSpec ##
- Unit Testing
- Integration Testing
- E2E Testing (API Testing)
