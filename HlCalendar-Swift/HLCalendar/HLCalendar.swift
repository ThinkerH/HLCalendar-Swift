//
//  HLCalendar.swift
//  HlCalendar-Swift
//
//  Created by HL on 17/2/25.
//  Copyright © 2017年 花磊. All rights reserved.
//

import UIKit

class HLCalendar: NSObject {

    static let shareInstance: HLCalendar = HLCalendar()
    
    var montherC: Int = 6 // 默认6个月
    var montherArr: NSMutableArray?
    var dateSource: NSMutableDictionary?
    
    
    let WeekDays = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    let ChineseMonths = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月","九月", "十月", "冬月", "腊月"]
    let ChineseDays = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
    
    
    // 获取date的下个月日期
    func nextMonthDateBy(date: Date) -> Date {
        var components: DateComponents = DateComponents()
        components.month = 1
        let nextMonthDate: Date = Calendar.current.date(byAdding: components, to: date)!
        return nextMonthDate
    }
    
    
    // 获取date的上个月日期
    func previousMonthDateBy(date: Date) -> Date {
        var comp: DateComponents = DateComponents()
        comp.month = -1
        let previousDate: Date = Calendar.current.date(byAdding: comp, to: date)!
        return previousDate
    }
    
    // 获取date当前月的第一天是星期几
    func weekdayOfFirstDayIn(date: Date) -> Int {
        var calendar: Calendar = Calendar.current
        calendar.firstWeekday = 1
        
        let componentSet: Set<Calendar.Component> = Set(arrayLiteral: .year, .month, .day)
        var comps: DateComponents = calendar.dateComponents(componentSet, from: date)
        comps.day = 1
        
        let firstDate: Date = calendar.date(from: comps)!
        let firstComps = calendar.dateComponents(Set(arrayLiteral: .weekday), from: firstDate)
        
        return firstComps.weekday! - 1
    }
    
    func weekDayOfDate(date: Date) -> Int {
        var calendar: Calendar = Calendar.current
        calendar.firstWeekday = 1
        let weekComps: DateComponents = calendar.dateComponents(Set(arrayLiteral: .weekday), from: date)
        return weekComps.weekday! - 1
    }
    
    func weekDayStrOfDate(date: Date) -> String {
        return WeekDays[weekDayOfDate(date: date)]
    }
    
    // 获取date当前月的总天数
    func totalDaysInMonthOfDate(date: Date) -> Int {
        let range: Range = Calendar.current.range(of: .day, in: .month, for: date)!
        return range.upperBound - 1
    }
    
    // 获取date当天的农历
    func chineseCalendarOfDate(date: Date) -> String {
        var day: String?
        let chineseCalendar = Calendar(identifier: .chinese)
        let comps: DateComponents = chineseCalendar.dateComponents(Set(arrayLiteral: .year, .month, .day), from: date)
        if comps.day == 1 {
            day = ChineseMonths[comps.month! - 1]
        } else {
            day = ChineseDays[comps.day! - 1]
        }
        return day!
    }
    
    func dateWith(dateStr: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
//        print(dateStr)
        
        return formatter.date(from: dateStr)!
    }
    
    func dateStrWith(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func monthesDataWith(date: Date, monthes: Int) -> NSMutableArray {
        if montherC == monthes && montherArr?.count == monthes {
            return montherArr!
        }
        
        montherC = monthes
        
        let months: NSMutableArray = NSMutableArray()
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        
        for i in 0..<monthes {
            var comps: DateComponents = calendar.dateComponents(Set(arrayLiteral: .year, .month), from: date)
            
            comps.year = 0
            comps.month = i
            
            let newDate = calendar.date(byAdding: comps, to: date)
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月"
            
            let str: String = formatter.string(from: newDate!)
            
            months.add(str)
        }
        
        montherArr = months.mutableCopy() as? NSMutableArray
        
        return montherArr!
    }
    
    func calendarDataWith(monthes: Int, fromDate: Date) -> NSMutableDictionary {
        
        if montherC == monthes && dateSource?.allKeys.count == monthes {
            return dateSource!
        }
        
        montherC = monthes
        
        let calendarData: NSMutableDictionary = NSMutableDictionary()
        
        for i in 0..<monthes {
            
            let curMonthDate: Date = dateWith(dateStr: monthesDataWith(date: fromDate, monthes: monthes)[i] as! String, format: "yyyy年MM月")
            
            let firstWeekDay: Int = weekdayOfFirstDayIn(date: curMonthDate)
            
            let totalDaysOfMonth: Int = totalDaysInMonthOfDate(date: curMonthDate)
            
            let monthArr: NSMutableArray = NSMutableArray()
            
            
            for j in 0..<Int(ceilf(Float(totalDaysOfMonth + firstWeekDay) / 7.0) * 7) {
                
                if j < firstWeekDay {
                    monthArr.add([
                            "day":"",
                            "chineseDay":"",
                            "date":""
                        ])
                    
                } else if j >= (totalDaysOfMonth + firstWeekDay) {
                    print(j)
                    monthArr.add([
                            "day":"",
                            "chineseDay":"",
                            "date":""
                        ])
                } else {
                    let day: Int = j - firstWeekDay + 1
                    
                    
                    let curDate: Date = dateWith(dateStr: String(format: "\(monthesDataWith(date: fromDate, monthes: monthes)[i])%02d日", day), format: "yyyy年MM月dd日")
                    
                    let comps0: DateComponents = Calendar.current.dateComponents(Set(arrayLiteral: .year, .month, .day), from: Date())
                    
                    let comps1: DateComponents = Calendar.current.dateComponents(Set(arrayLiteral: .year, .month, .day), from: curDate)
                    
                    if comps0.year == comps1.year && comps0.month == comps1.month && comps0.day == comps1.day {
                        monthArr.add([
                                "day":"今天",
                                "chineseDay":chineseCalendarOfDate(date: curDate),
                                "date":curDate
                            ])
                    } else if comps0.year == comps1.year && comps0.month == comps1.month && (comps0.day! + 1) == comps1.day! {
                        monthArr.add([
                            "day":"明天",
                            "chineseDay":chineseCalendarOfDate(date: curDate),
                            "date":curDate
                            ])
                    } else {
                        monthArr.add([
                            "day":"\(day)",
                            "chineseDay":chineseCalendarOfDate(date: curDate),
                            "date":curDate
                            ])
                    }
                }
                
            }
            
            calendarData.setObject(monthArr, forKey: monthesDataWith(date: fromDate, monthes: monthes)[i] as! NSCopying)
        }
        
        dateSource = calendarData.mutableCopy() as? NSMutableDictionary
        
        return dateSource!
    }
    
}
