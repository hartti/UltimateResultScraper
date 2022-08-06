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
      
      let homeTeamRoster = parseRosterPelikone(homeTeam: true)
      let awayTeamRoster = parseRosterPelikone(homeTeam: false)
      
      if let items = title.wholeMatch(of: titleMatcher) {
        return ScrapedGame(homeTeamName: String(items.1), homeTeamScore: Int(items.3), homeTeamRoster: homeTeamRoster, awayTeamName: String(items.2), awayTeamScore: Int(items.4), awayTeamRoster: awayTeamRoster)
      }
      return nil
    } catch Exception.Error(_, let message) {
      print(message)
    } catch {
      print("error")
    }
    return nil
  }
  
  func parseRosterPelikone(homeTeam: Bool) -> [ScrapedPlayer] {
    let homeTeamClass = "home"
    let awayTeamClass = "guest"
    
    var players: [ScrapedPlayer] = []
    
    do {
      let teamTest = try doc.getElementsByClass(homeTeam ? homeTeamClass : awayTeamClass).first()!.parents()[1]
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
