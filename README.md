# Parser

Parser is a ruby script that:
1. Receives a log as argument.
    1. e.g. `logs/webserver.log` 
2. Returns the following:
    2. A list of webpages with the most page views, ordered from the most pages views to the least page views.
    2. A list of webpages with the most unique page views also ordered.

### Design Approach
1. Effiency. Keeping the code Clean using DRY and single responsibility methodologies.
2. Readability. All code must be understandable without needing to "double check" what it does.
3. Tests. All functionality should be covered by Unit and Integration tests.
4. Build. To be built using Test Driven Development and Object Orientated Programming.
