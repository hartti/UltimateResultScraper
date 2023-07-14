import Foundation
import SwiftSoup
import RegexBuilder

public class UltimateResultScraper {
  var url: String? = nil
  var html: String? = nil
  var gameScraper: GenericGameScraper? = nil
  
  public init(html: String) {
    self.html = html
  }
  
  public init(url: String) {
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
  
  public func scrapeGame() async throws -> ScrapedGame? {
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
    return gameScraper!.scrapeGame()
  }
  
  public static func urlSupported(_ url: String) -> Bool {
    return (url.starts(with: "https://ultimate.fi/pelikone/?view=gameplay") && url != "https://ultimate.fi/pelikone/?view=gameplay") ||
    (url.starts(with: "https://play.usaultimate.org/teams/events/match_report/?") && url != "https://play.usaultimate.org/teams/events/match_report/?") ||
    (url.starts(with: "https://results.wfdf.sport/") && url != "https://results.wfdf.sport/")
  }
}

class GenericGameScraper {
  func scrapeGame() -> ScrapedGame? {
    return nil
  }
}

extension String: Error {} // Enables you to throw a string


