import Foundation
import SwiftSoup
import RegexBuilder

public class UltimateResultScraper {
  var url: String? = nil
  var html: String? = nil
  var gameScraper: GenericGameScraper? = nil
  
  init(html: String) {
    self.html = html
  }
  
  init(url: String) {
    self.url = url
  }
  
  func downloadPage(url: String) async throws -> String {
    guard let url = URL(string: url) else {
      return ""
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let contents = String(decoding: data, as: UTF8.self)
    return contents
  }
  
  func parseGame() async throws -> ParsedGame? {
    if html == nil {
      if url == nil {
        throw "No page URL provided"
      }
      try await html = downloadPage(url: url!)
      if html == nil {
        throw "No page to parse"
      }
    }
    let html = html!
    let doc: Document = try SwiftSoup.parse(html)
    if html.contains("usaultimate.org") {
      gameScraper = GameScraperUSAU(doc: doc)
    } else if html.contains("wucc.sport") || html.contains("ultimate.fi/pelikone") {
      gameScraper = GameScraperPelikone(doc: doc)
    } else {
      throw "Unknown page format / source"
    }
    return gameScraper!.parseGame()
  }
}

class GenericGameScraper {
  func parseGame() -> ParsedGame? {
    return nil
  }
}

extension String: Error {} // Enables you to throw a string


