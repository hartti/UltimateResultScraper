//
//  GameScraper.swift
//  
//
//  Created by Hartti Suomela on 8/5/22.
//

import Foundation
import SwiftSoup
import RegexBuilder

class GameScraperUSAU: GenericGameScraper {
  let doc: Document
  
  init(doc: Document) {
    self.doc = doc
  }
  
  override func scrapeGame() -> ScrapedGame? {
    let homeTeamNameId = "CT_Main_0_lblHomeTeam"
    let awayTeamNameId = "CT_Main_0_lblAwayTeam"
    let homeTeamScoreId = "CT_Main_0_lblHomeScore"
    let awayTeamScoreId = "CT_Main_0_lblAwayScore"
    
    let nameWithRankMatcher = /(.+)\ \(\d+\)/
    let dateMatcher = Regex {
      Capture {
        One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .current))
      }
    }
    
    do {
      var homeTeamName = try doc.getElementById(homeTeamNameId)?.text() ?? ""
      if let matches = homeTeamName.firstMatch(of: nameWithRankMatcher) {
        homeTeamName = String(matches.1)
      }
      
      var awayTeamName = try doc.getElementById(awayTeamNameId)?.text() ?? ""
      if let matches = awayTeamName.firstMatch(of: nameWithRankMatcher) {
        awayTeamName = String(matches.1)
      }
      
      let homeTeamScore = try Int(doc.getElementById(homeTeamScoreId)?.text() ?? "")
      let awayTeamScore = try Int(doc.getElementById(awayTeamScoreId)?.text() ?? "")
      
      let titleString = try doc.getElementsByClass("title").first()?.text() ?? ""
      let date = titleString.firstMatch(of: dateMatcher)?.1
      
      let homeTeamRoster = parseRosterUSAU(homeTeam: true)
      let awayTeamRoster = parseRosterUSAU(homeTeam: false)
      
      return ScrapedGame(date: date, homeTeamName: homeTeamName, homeTeamScore: homeTeamScore, homeTeamRoster: homeTeamRoster, awayTeamName: awayTeamName, awayTeamScore: awayTeamScore, awayTeamRoster: awayTeamRoster)
      
    } catch Exception.Error(_, let message) {
      print(message)
    } catch {
      print("error")
    }
    return nil
  }
  
  func parseRosterUSAU(homeTeam: Bool) -> [ScrapedPlayer] {
    let homeTeamRosterListId = "CT_Main_0_gvHomeList"
    let awayTeamRosterListId = "CT_Main_0_gvAwayList"
    
    var players: [ScrapedPlayer] = []
    
    do {
      let teamTable = try doc.getElementById(homeTeam ? homeTeamRosterListId : awayTeamRosterListId)
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

