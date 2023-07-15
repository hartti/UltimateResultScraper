# UltimateResultScraper

This package scrapes various ultimate game report pages and returns a Swift structure which contains teams, score and rosters. Currently the package supports USA Ultimate and Pelikone-based (Finnish Flying Disc Association and WFDF) systems.

## Usage

Create an instance of the scraper either using an URL or HTML-contents and call scrapeGame-function. The package detects the game report format and scrapes
- Team names
- Team scores
- Player names and jersey numbers

The package returns a Swift struct (ParsedGame) which contains team1 (usually home team) and team2 (usually away team) with name and score and roster array. If certain data was not found that variable is then nil (Optional).

## Examples of pages one can scrape
 - Pelikone on Finnish Flying Disc Association games, like
   - https://ultimate.fi/pelikone/?view=gameplay&game=9909
   - https://ultimate.fi/pelikone/?view=gameplay&game=9903
- USA Ultimate game reporter pages, like
  - https://play.usaultimate.org/teams/events/match_report/?EventGameId=pLJmnX%2fIgkBxnvDh%2bQce%2bNK53CyXxeOu5bfVd0bUtX8%3d
  - https://play.usaultimate.org/teams/events/match_report/?EventGameId=eLCr%2fwlCKPdM7WcIZ%2bdd%2fdGygkvvAthCfZiXwjNNBUc%3d
- WFDF tournament games, like 
  - https://results.wfdf.sport/wu24/?view=gameplay&game=193
  - https://results.wfdf.sport/wucc/?view=gameplay&game=152

## Future improvements
- implement some tests
- Parse game flow (score order and possibly also scorer information with time stamps)
- Parse player and team summary pages
- Handle errors and exceptions better

