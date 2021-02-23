//
//  File.swift
//  
//
//  Created by zy on 2021/2/23.
//
import Foundation

public extension String {
    var zyz_localStr: String {
        return NSLocalizedString(self, comment: "")
    }
}

public extension Date {
    var zyz_dayString: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let dateStr = df.string(from: self)
            return dateStr
        }
    }
    
    var zyz_secString: String {
          get {
              let df = DateFormatter()
              df.dateFormat = "yyyy-MM-dd HH:mm:ss"
              let dateStr = df.string(from: self)
              return dateStr
          }
      }
}
