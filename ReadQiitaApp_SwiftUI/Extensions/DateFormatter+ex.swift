//
//  Date+ex.swift
//  ReadQiitaApp_SwiftUI
//
//  Created by 土橋正晴 on 2024/03/15.
//

import Foundation

extension DateFormatter {
    

    private static func _dateFormatter(type: FormatType) -> DateFormatter {
          let formatter: DateFormatter = DateFormatter()
          formatter.dateFormat = switch type {
          case .secnd: "yyyy/MM/dd HH:mm:ss"
          case .date: "yyyy年MM月dd日"
          default: "yyyy/MM/dd HH:mm"
          }
          
          formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
          formatter.locale = Locale(identifier: "en_US_POSIX")
          
          return formatter
      }
      
      
      /// Stringのフォーマットを設定Dateを返す
      static func dateFromString(string: String, type: FormatType) -> Date? {
          let formatter: DateFormatter = _dateFormatter(type: type)
          return formatter.date(from: string)
      }
      
      
      /// Dateのフォーマットを設定しStringを返す
      static func stringFromDate(date: Date, type: FormatType) -> String {
          let formatter = _dateFormatter(type: type)
          let s_Date:String = formatter.string(from: date)
          
          return s_Date
      }
      
    /// 文字列の日時のフォーマットを変換して返す
    static func stringFromString(_ dateStr: String, type: FormatType) -> String {
         var dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
         let date = dateFormatter.date(from: dateStr)
         
         if let date {
             dateFormatter = DateFormatter._dateFormatter(type: type)
             return dateFormatter.string(from: date)
         } else {
             return ""
         }
     }
    
    
    
      
      /// 現在時間をフォーマット設定して返す
      static func dateFormatNow(type: FormatType) -> Date {
          let formatter = DateFormatter._dateFormatter(type: type)
          let s_Date:String = formatter.string(from: Date())
          
          return formatter.date(from: s_Date) ?? Date()
      }
      
      enum FormatType {
          case secnd
          case date
          case None
      }
}
