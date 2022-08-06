//
//  Models.swift
//  
//
//  Created by Hartti Suomela on 8/5/22.
//

import Foundation

public struct ParsedGame {
  let date: Date?
  let homeTeam: ParsedTeam
  let awayTeam: ParsedTeam
  
  init(date: Date? = nil, homeTeamName: String, homeTeamScore: Int?, homeTeamRoster: [ParsedPlayer]? = nil, awayTeamName: String, awayTeamScore: Int?, awayTeamRoster: [ParsedPlayer]? = nil) {
    self.date = date
    homeTeam = ParsedTeam(name: homeTeamName, score: homeTeamScore, roster: homeTeamRoster)
    awayTeam = ParsedTeam(name: awayTeamName, score: awayTeamScore, roster: awayTeamRoster)
  }
}

public struct ParsedTeam {
  let name: String
  let score: Int?
  let roster: [ParsedPlayer]
  
  init(name: String, score: Int?, roster: [ParsedPlayer]? = nil) {
    self.name = name
    self.score = score
    if roster != nil {
      self.roster = roster!
    } else {
      self.roster = []
    }
  }
}

public struct ParsedPlayer {
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
