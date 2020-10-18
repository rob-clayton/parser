# Parser

Parser is a ruby script that:
1. Receives a log as argument.
    1. e.g. `logs/webserver.log` 
1. Returns the following:
    1. A list of webpages with the most page views, ordered from the most pages views to the least page views.
    1. A list of webpages with the most unique page views also ordered.

## Design Approach
1. Effiency. Keeping the code Clean using DRY and single responsibility methodologies.
1. Readability. All code must be understandable without needing to "double check" what it does.
1. Tests. All functionality should be covered by Unit and Integration tests.
1. Build. To be built using Test Driven Development and Object Orientated Programming.

## How to run the script
### Set-up:
You will need to install Ruby 2.7.2. Here is an example of how to install with rbenv:
1. Install brew: https://brew.sh/. 
1. `brew install rbenv` if you already have rbenv you may need to upgrade it `brew upgrade rbenv`.
1. To view available Ruby versions `rbenv install -l`. For MacOS: if 2.7.2 is not availble you may need to run `brew upgrade ruby-build`.
1. Install Ruby 2.7.2: `rbenv install 2.7.2`

Once Ruby is installed you need to install the gems. Here is an example of how to install with bundler:
1. `gem install bundler`
1. `bundle install`

### Running the script:
1. You will need to change the privileges of `parser.sh` to allow you to execute the script from terminal: `chmod +x bin/parser.sh`
1. To run the script call `parser.sh` whilst passing it a log file as an argument. There is a `webserver.log` file in `/logs`, so as an example you can run: `bin/parser.sh logs/webserver.log`
