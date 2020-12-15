# README

Congratulations! You've made it to the coding challenge part of the interview for the BriteVerify team at Validity. 

At Validity, we invest heavily in our developers. For that reason, we want to make sure we’re only hiring the best engineers; to do that, we have to see how you code and solve problems, not in front of a white board but at a keyboard. This is your opportunity to shine, to show us how good you are and for us to see what we can expect if we were to hire you. You will demonstrate your ability to understand a problem, find a solution, code that solution and present it to us, in terms of code comments, README, and explanations during the in-person interviews.

We're very excited to see what you create. If at any point, you have questions on the exercise or anything is unclear, please don't hesistate to reach out. Let's get started!

## The Problem

This repo comes complete with a dockererized rails api--with a few bugs. It is your job to clone this repo, build the docker image, and find the bugs. In the below sections are an itemized list of tasks we'd like you to complete before submitting the challenge. Additionally, if you find that too easy and are looking for an extra challenge, we encourage you to try out the bonus tasks! They are, of course, in no way required and will not reflect against you.



## Overall Challenge:
A lot of my time was spent on what surrounded the code. I learned how to set up a docker container and understand the logs, set up a ruby environment, basic ruby syntax (since this was my first time with it) ,and setting up postgres. 

# Lost some time in task 1 as I wanted to prevent an invalid email from being created in the DB, not just have an invalid value for the verification_status key… Was a bit of a tough point viewing the data passing between controller and model in the console- tried using the docker logger at one point for this. 
# I’m familiar with the MVC structure- but jumping into ruby was a bit of an obstacle, lost time and pseudocode the remaining tasks. That said if I had the ruby foundation this would be complete...


## The Solution

Given this clone repo, we ask that you push into your own github account. Then create a PR with all of the changes you made so it is easy for us to see the work you've put into this challenge. Feel free to document any changes via comments, writing your own README, etc.

## Dependencies

### Docker

You might be required to create a Docker account if you do not already have one already.

[Docker Tutorial](https://www.docker.com/get-started)
[Install Docker for Mac](https://docs.docker.com/docker-for-mac/)
[Install Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
[Docker-Compose](https://docs.docker.com/compose/) (optional reading)

### Postman

We recommend using Postman for API calls, feel free to use any platform you feel comfortable with.

[Download Postman](https://www.getpostman.com/downloads/)

### Rspec Best Pracices

For those unfamiliar with rspec.

[Better Specs](http://www.betterspecs.org/)

## Initial Setup

To begin, run the following commands after cloning and stepping inside the repo.
The presetup only needs to be completed once. If the rails server is not started using `docker-compose up` then start the rails server with the IP binding flag.

```
docker-compose up --build
docker-compose up --no-start
docker-compose run --rm --service-ports web bash
./presetup.sh
rails s -p 3000 -b '0.0.0.0'
```

This builds the docker container, starts the container, sets up the database, and starts the rails server.

In a separate tab, to get list of currently running docker containers
`docker ps`

This will return a list similar to this:
```
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                     NAMES
186241d08ca4        briteverify_sample_web   "entrypoint.sh bash"     8 minutes ago       Up 8 minutes        0.0.0.0:3000->3000/tcp    briteverify_sample_web_run_b0ef66d0fcff
```

To enter into a docker container, use the `CONTAINER ID` or `NAMES`:

- `docker exec -it 186241d08ca4 bash`
- `docker exec -it briteverify_sample_web_run_b0ef66d0fcff bash`

This will allow you to connect to the container you opened in the first step with the `docker-compose run` or `docker-compose up` command.
Once the container has been built and the `presetup` script run, any time you exit the docker and want to restart, you can simply do a `docker-compose up` and the rails server will automatically start with the IP binding.

## Explore the App

This application is meant to do a simple validation on email format. It is already set up to handle RESTful requests with the email_verification API. To try out some of the functionality, go to the rails console or in Postman, try a couple of API requests.

Create a new verification via API call:

```
curl -X POST \
  http://localhost:3000/api/v1/email_verifications \
  -H 'Content-Type: application/json' \
  -d '{
    "email_verification": {
    	"address": "tyler.cone@validity.com"
    }
}'
```

Create a new verification via rails console:

`EmailAddress.create(address: 'foo@bar.com').check_status`

It looks like it's working!

Lets try one more command:

`EmailAddress.create(address: 'foobar.com').check_status`

Uh oh! Seems like we have a bug. Let's run our rspec tests and see if we can figure out what happened here. Exit out of the rails console and run rspec:

`rspec .` or `rspec /spec`

Seems like something is not quite right, a test is failing! Please continue on to see the list of tasks.

## The Tasks

Please feel free to spend as much time as you'd like on this challenge. We do recommend timeboxing it to around 4 hours so as not to consume too much of your time.

Check out the bonus section if you would like an extra challenge! There is no penalty for not completing any bonuses. The main tasks should be completed first and are of higher priority.

### Task 1

Fix the failing test by implementing verification logic in the `EmailAddress#check_status` method. This is where your creativity can flouish! When you've finished, the rspec tests should pass.

### Task 2

Currently, the API only accepts one email at a time. It would nice if we had the option to verify a whole list at one time. Implement a way to pass in up to 10 emails at once, and return a status for each.

Bulk API requirements:
- allow anywhere from 1 to 10 email addresses
- return the list of email addresses with their corresponding statuses

Bonus:
- return an error if no email addresses are present
- return an error when more than 10 email addresses are present


### Task 3

Turns out our API is open to the public! Let's lock this down following these requirements:

- allow only _active_ users in the database to have access to the API (remember that users in the database can be active or inactive)
- only existing users can gain access to the API
 # I think there should be a method running that will check the status of current user. if inactive, return, otherwise continue to verification method. a current user object should be created anyways for future functionality and should be globally accessible to all controllers once a user is signed into our application, then we can set permissions, or refference the object to grant access to specific features before executing methods in those files..

Again, let your creativity flourish. Be sure to document the new API call in your README updates--we love examples!

### Task 4

Let's give this API a UI! Add a basic form for verifying an email address to the `main_controller` and connect it to either of the APIs. Return the status of the response however you see fit.


## Bonus Tasks

The below are listed in no particular order, complete as few or as many as you'd like.

- Due to security and privacy concerns, we do not want to store raw emails in our database. Implement a way to store results, but also not expose raw emails in the database.
# I think here, some cool regex could be implemented, which can consistently replace soem characters and letters to almost "sanitize the data", then whne we are making get requests the same could be performed to retreive the data and restore it..
- Allow a CSV upload feature in the UI that can verify up to 100 emails (modify the Bulk API to handle a larger load).
# while iterating through the content of the CSV, could be useful to implement stack datastructure in this case... depending on format of CSV
# if there are characters consistently marking the start and beginning of an entry, could append a start extract the data to an array, pop the start when an end is found, and continue through the entire file. Once complete, push the array to the verification method and operate on each email, return true or false or 'valid' or 'invalid' for statuses of each..
- Create a Postman collection to test a valid and invalid endpoint.
- Write rspec tests for the new logic you've implemented in the models and controllers.
