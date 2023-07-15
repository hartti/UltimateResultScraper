//
//  GameScraperPelikone.swift
//  
//
//  Created by Hartti Suomela on 8/5/22.
//

import Foundation
import SwiftSoup

class GameScraperPelikone: GenericGameScraper {
  let doc: Document
  
  init(doc: Document) {
    self.doc = doc
  }
  
  override func scrapeGame() -> ScrapedGame? {
    let titleMatcher = /(.+)\ \-\ (.+)&nbsp;&nbsp;&nbsp;&nbsp;(\d+)\ \-\ (\d+)/
    
    do {
      let title = try doc.select("h1").first()!.html()
      
      let team1Roster = parseRosterPelikone(forTeam1: true)
      let team2Roster = parseRosterPelikone(forTeam1: false)
      
      if let items = title.wholeMatch(of: titleMatcher) {
        return ScrapedGame(team1Name: String(items.1), team1Score: Int(items.3), team1Roster: team1Roster, team2Name: String(items.2), team2Score: Int(items.4), team2Roster: team2Roster)
      }
      return nil
    } catch Exception.Error(_, let message) {
      print(message)
    } catch {
      print("error")
    }
    return nil
  }
  
  func parseRosterPelikone(forTeam1: Bool) -> [ScrapedPlayer] {
    let team1Class = "home"
    let team2Class = "guest"
    
    var players: [ScrapedPlayer] = []
    
    do {
      let teamTest = try doc.getElementsByClass(forTeam1 ? team1Class : team2Class).first()!.parents()[1]
      let rows = try teamTest.select("tr")
      for row in rows {
        let cells = try row.select("td")
        if cells.count == 0 {
          continue
        }
        let number = try cells[0].html()
        let name = try cells[0].select("a").html()
        let temp = ScrapedPlayer(name: name, jerseyNumber: number)
        players.append(temp)
      }
    } catch Exception.Error(_, let message) {
      print(message)
      print("Errorissa")
    } catch {
      print("error")
    }
    return players
  }
}
