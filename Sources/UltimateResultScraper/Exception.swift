//
//  File.swift
//  
//
//  Created by Hartti Suomela on 7/14/23.
//

import Foundation

public enum ExceptionType {
  case NoSourceException
  case UnknownFormatException
  case ParseException
}

public enum Exception: Error {
  case Error(type: ExceptionType, Message: String)
}
