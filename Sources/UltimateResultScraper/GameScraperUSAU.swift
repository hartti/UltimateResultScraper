//
//  GameScraper.swift
//  
//
//  Created by Hartti Suomela on 8/5/22.
//

import Foundation
import SwiftSoup
import RegexBuilder

class GameScraperUSAU: GameScraper {
  let doc: Document
  
  init(doc: Document) {
    self.doc = doc
  }
  
  override func scrapeGame() -> ScrapedGame? {
    let team1NameId = "CT_Main_0_lblHomeTeam"
    let team2NameId = "CT_Main_0_lblAwayTeam"
    let team1ScoreId = "CT_Main_0_lblHomeScore"
    let team2ScoreId = "CT_Main_0_lblAwayScore"
    
    let nameWithRankMatcher = /(.+)\ \(\d+\)/
    let dateMatcher = Regex {
      Capture {
        One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .current))
      }
    }
    
    do {
      var team1Name = try doc.getElementById(team1NameId)?.text() ?? ""
      if let matches = team1Name.firstMatch(of: nameWithRankMatcher) {
        team1Name = String(matches.1)
      }
      
      var team2Name = try doc.getElementById(team2NameId)?.text() ?? ""
      if let matches = team2Name.firstMatch(of: nameWithRankMatcher) {
        team2Name = String(matches.1)
      }
      
      let team1Score = try Int(doc.getElementById(team1ScoreId)?.text() ?? "")
      let team2Score = try Int(doc.getElementById(team2ScoreId)?.text() ?? "")
      
      let titleString = try doc.getElementsByClass("title").first()?.text() ?? ""
      let date = titleString.firstMatch(of: dateMatcher)?.1
      
      let team1Roster = parseRosterUSAU(forTeam1: true)
      let team2Roster = parseRosterUSAU(forTeam1: false)
      
      return ScrapedGame(date: date, team1Name: team1Name, team1Score: team1Score, team1Roster: team1Roster, team2Name: team2Name, team2Score: team2Score, team2Roster: team2Roster)
      
    } catch Exception.Error(_, let message) {
      print(message)
    } catch {
      print("error")
    }
    return nil
  }
  
  func parseRosterUSAU(forTeam1: Bool) -> [ScrapedPlayer] {
    let team1RosterListId = "CT_Main_0_gvHomeList"
    let team2RosterListId = "CT_Main_0_gvAwayList"
    
    var players: [ScrapedPlayer] = []
    
    do {
      let teamTable = try doc.getElementById(forTeam1 ? team1RosterListId : team2RosterListId)
      let rows = try teamTable?.select("tr")
      for row in rows! {
        if let playerString = try row.select("td").first()?.text() {
          let words = playerString.split(separator: " ")
          let number = words[0].trimmingCharacters(in: ["#"])
          let name = words[1..<words.count].joined(separator: " ")
          let temp = ScrapedPlayer(name: name, jerseyNumber: number)
          players.append(temp)
        }
      }
    } catch Exception.Error(_, let message) {
      print(message)
    } catch {
      print("error")
    }
    return players
  }
}

