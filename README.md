# README

Hi Josef! Here's what I've done with the AirBnB profit calculator.  

## In short, here's what it does:
- The `new` action in the CalculationController is the main page.  The reasoning
  behind this is that, in keeping with making the routes RESTful, we're making
  this be tha page where one would submit information to the server for
  processing
- The `create` action gets called when the form is submitted
  - Calls AirBnB scraper which then looks on AirBnB for the proper information
  - Checks AirBnB's price to see whether it's a weekly, monthly, or yearly price
    and adjusts it accordingly
  - Note: The method of scraping is a little bit brittle given the time
    constraints, but there are notes in the comments in the class for ways
    I would have made it workgiven more time
- `create` then renders the 'new' action again with certain query string params
  which will show the outputs below the form fields

## Other notes of interest:
- I used e2e testing mostly to check that the connection works and that my
  scraping algorithm works more or less, but I wanted to keep the number of
  requests on there to a minimum, given how much time they take.
  - As a result, I opted for more integration tests and then mocked out the
    response that I would have gotten from scraping AirBnB
- I limited the google autocomplete to go by city to decrease the possibilities
  of errors arising if we tried to do the address parsing manually
- The key I put in for the google autocorrect straight in the html view.  In
  practice this is normally very dangerous, and I would normally use Figaro or
  another gem of hiding environment variables and put the key in there.  I opted
  not to do that here because I wanted to reduce the hassle for you in setting
  up the app so you could get right to it.  The key is for a throwaway account
  anyway, so it shouldn't hurt anything
- And finally!
  - Although some of my documentation is in the comments, I usually prefer to
    put my documentation in the git commit messages (makes `git blame` a lot
    more explanatory for future developers), feel free to look at them there!
