//
//  Models.swift
//  
//
//  Created by Hartti Suomela on 8/5/22.
//

import Foundation

public struct ScrapedGame {
  public let date: Date?
  public let team1: ScrapedTeam
  public let team2: ScrapedTeam
  
  init(date: Date? = nil, team1Name: String, team1Score: Int?, team1Roster: [ScrapedPlayer]? = nil, team2Name: String, team2Score: Int?, team2Roster: [ScrapedPlayer]? = nil) {
    self.date = date
    team1 = ScrapedTeam(name: team1Name, score: team1Score, roster: team1Roster)
    team2 = ScrapedTeam(name: team2Name, score: team2Score, roster: team2Roster)
  }
}

public struct ScrapedTeam {
  public let name: String
  public let score: Int?
  public let roster: [ScrapedPlayer]
  
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
  public let name: String
  public let jerseyNumber: String    // to allow double zero
  public let assists: Int?
  public let goals: Int?
  public let totalPoints: Int?
  
  init(name: String, jerseyNumber: String, assists: Int? = nil, goals: Int? = nil, totalPoints: Int? = nil) {
    self.name = name
    self.jerseyNumber = jerseyNumber
    self.assists = assists
    self.goals = goals
    self.totalPoints = totalPoints
  }
}
