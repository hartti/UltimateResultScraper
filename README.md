# UltimateResultScraper

This package scrapes various ultimate game report pages and returns a Swift structure which contains teams, score and rosters. Currently the package supports USA Ultimate and Pelikone-based (Finnish Flying Disc Association and WFDF) systems.

## Usage

Create an instance of the scraper either using an URL or HTML-contents and call scrapeGame-function. The package detects the game report format and scrapes
- Team names
- Team scores
- Player names and jersey numbers

The package returns a Swift struct (ParsedGame) which contains team1 (usually home team) and team2 (usually away team) with name and score and roster array. If certain data was not found that variable is then nil (Optional).

## Future improvements
- Parse game flow (score order and possibly also scorer information with time stamps)
- Parse player and team summary pages
- Handle errors and exceptions better

