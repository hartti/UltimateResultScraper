//
//  Models.swift
//  
//
//  Created by Hartti Suomela on 8/5/22.
//

import Foundation

public struct ScrapedGame {
  let date: Date?
  let homeTeam: ScrapedTeam
  let awayTeam: ScrapedTeam
  
  init(date: Date? = nil, homeTeamName: String, homeTeamScore: Int?, homeTeamRoster: [ScrapedPlayer]? = nil, awayTeamName: String, awayTeamScore: Int?, awayTeamRoster: [ScrapedPlayer]? = nil) {
    self.date = date
    homeTeam = ScrapedTeam(name: homeTeamName, score: homeTeamScore, roster: homeTeamRoster)
    awayTeam = ScrapedTeam(name: awayTeamName, score: awayTeamScore, roster: awayTeamRoster)
  }
}

public struct ScrapedTeam {
  let name: String
  let score: Int?
  let roster: [ScrapedPlayer]
  
  init(name: String, score: Int?, roster: [ScrapedPlayer]? = nil) {
    self.name = name
    self.score = score
    if roster != nil {
      self.roster = roster!
    } else {
      self.roster = []
    }
  }
}

public struct ScrapedPlayer {
  let name: String
  let jerseyNumber: String    // to allow double zero
  let assists: Int?
  let goals: Int?
  let totalPoints: Int?
  
  init(name: String, jerseyNumber: String, assists: Int? = nil, goals: Int? = nil, totalPoints: Int? = nil) {
    self.name = name
    self.jerseyNumber = jerseyNumber
    self.assists = assists
    self.goals = goals
    self.totalPoints = totalPoints
  }
}
