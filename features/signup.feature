Feature: Sign up
As a new user
I want to signup with my details
So that I can login
 
Scenario: Sucessful sign up
  Given a user without an account
  When he creates a new account
  Then he should see "Welcome back, trusted user!"
