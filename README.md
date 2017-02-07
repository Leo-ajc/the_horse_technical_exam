# Unboxed Technical Test

We would like you to build a simple web or command line application, which should allow users to enter an arbitrary GitHub username, and be presented with a best guess of the GitHub user's favourite programming language.

This can be computed by using the GitHub API to fetch all of the user's public GitHub repos, each of which includes the name of the dominant language for the repository.
Documentation for the GitHub API can be found at http://developer.github.com

There is no recommended timeframe for you to complete this exercise in, do what you need to do to showcase the very best of your ability. You are also not obliged to complete the full exercise but we do ask for an indication on the amount of time that you spend completing the exercises. Please will you use this exercise to showcase your strengths in Ruby/Rails.

---

Deployed at: [https://unboxed-technical-exam-leo.herokuapp.com/](https://unboxed-technical-exam-leo.herokuapp.com/)

# The Gist

lib/guess_favorite_language.rb

app/controllers/favorites_controller.rb

## The tests

features/guess_favorite_language.feature

spec/guess_spec.rb
