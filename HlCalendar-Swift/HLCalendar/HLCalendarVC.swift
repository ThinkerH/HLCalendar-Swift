//
//  HLCalendarVC.swift
//  HlCalendar-Swift
//
//  Created by HL on 17/2/26.
//  Copyright © 2017年 花磊. All rights reserved.
//

import UIKit

class HLCalendarVC: UIViewController {

    var selectDateBlcok: ((_ date: Date, _ dateStr: String) -> ())?
    
    var montherNum: Int?
    var monthes: NSMutableArray?
    var dateSource: NSMutableDictionary?
    
    var selectDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "选择日期"
        view.backgroundColor = WHITE_COLOR
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancleBtnAction))
        
        monthes = HLCalendar.shareInstance.monthesDataWith(date: Date(), monthes: ((montherNum != nil && montherNum! != 0) ? montherNum! : 6))
        dateSource = HLCalendar.shareInstance.calendarDataWith(monthes: ((montherNum != nil && montherNum! != 0) ? montherNum! : 6), fromDate: Date())
        
        
        setUpCollectionView()
        
    }
    
    func setUpCollectionView() -> Void {
        let itemW: CGFloat = (UIScreen.main.bounds.width - 5 * 2) / 7
        let itemH: CGFloat = itemW + 4
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        flowLayout.itemSize = CGSize(width: itemW, height: itemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CalendarDayCVCell.classForCoder(), forCellWithReuseIdentifier: "CalendarCell")
        collectionView.register(CalendarHeaderCRV.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CalendarHeader")
        
    }
    
    func cancleBtnAction() -> Void {
        dismiss(animated: true, completion: nil)
    }

    
    func didSelectDate(selBlock: ((_ date: Date, _ dateStr: String) -> ())?) -> Void {
        if selBlock != nil {
            selectDateBlcok = selBlock
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HLCalendarVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if dateSource == nil {
            return 0
        } else {
            return dateSource!.allKeys.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let days: NSArray = dateSource![monthes![section]] as! NSArray
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
            let ident: String = "CalendarHeader"
            let header: CalendarHeaderCRV = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ident, for: indexPath) as! CalendarHeaderCRV
            header.monthLab.text = monthes![indexPath.section] as? String
            return header
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ident: String = "CalendarCell"
        let cell: CalendarDayCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: ident, for: indexPath) as! CalendarDayCVCell
        
        let rowArr: NSArray = dateSource![monthes![indexPath.section]] as! NSArray
        let rowDic: [String: Any] = rowArr[indexPath.row] as! [String: Any]
        
        cell.dayLab?.text = rowDic["day"] as? String
        cell.chineseLab?.text = rowDic["chineseDay"] as? String
        
        let date = rowDic["date"]
        
        if date! is Date {
            cell.date = date as? Date
            cell.isUserInteractionEnabled = true
            
            // 今天
            let compsToDay: DateComponents = Calendar.current.dateComponents(Set(arrayLiteral: .year, .month, .day), from: Date())
            
            // 当前日
            let compsCurDay: DateComponents = Calendar.current.dateComponents(Set(arrayLiteral: .year, .month, .day), from: date as! Date)
            
            if selectDate != nil {
                // 选中日
                let compsSelDay: DateComponents = Calendar.current.dateComponents(Set(arrayLiteral: .year, .month, .day), from: selectDate!)
                
                if compsSelDay.year! == compsCurDay.year! && compsSelDay.month! == compsCurDay.month! && compsSelDay.day! == compsCurDay.day! {
                    cell.isSelect = true
                } else {
                    cell.isSelect = false
                }
                
            } else {
                if compsToDay.year! == compsCurDay.year! && compsToDay.month! == compsCurDay.month! && compsToDay.day! == compsCurDay.day! {
                    cell.isSelect = true
                } else {
                    cell.isSelect = false
                }
            }
            
            if cell.isSelect == true {
                cell.backView?.backgroundColor = MAIN_COLOR
                cell.dayLab?.textColor = WHITE_COLOR
                cell.chineseLab?.textColor = WHITE_COLOR
            } else {
                cell.backView?.backgroundColor = WHITE_COLOR
                cell.chineseLab?.textColor = COLOR(r: 165.0, g: 177.0, b: 188.0, a: 1.0)
                if compsToDay.year! == compsCurDay.year! && compsToDay.month! == compsCurDay.month! && compsToDay.day! > compsCurDay.day! {
                    cell.dayLab?.textColor = COLOR(r: 165.0, g: 177.0, b: 188.0, a: 1.0)
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                    if HLCalendar.shareInstance.weekDayOfDate(date: cell.date!) == 0 || HLCalendar.shareInstance.weekDayOfDate(date: cell.date!) == 6 {
                        cell.dayLab?.textColor = COLOR(r: 35.0, g: 182.0, b: 245.0, a: 1.0)
                    } else {
                        cell.dayLab?.textColor = UIColor.black
                    }
                }
            }
        } else {
            cell.backView?.backgroundColor = WHITE_COLOR
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectDateBlcok != nil {
            
            let cell: CalendarDayCVCell = collectionView.cellForItem(at: indexPath) as! CalendarDayCVCell
            
            selectDate = cell.date
            collectionView.reloadData()
            
//            selectDateBlcok(cell.date, "\(HLCalendar.shareInstance.dateStrWith(date: cell.date, format: "MM月dd日")\()")
            
            let str0: String = HLCalendar.shareInstance.dateStrWith(date: cell.date!, format: "MM月dd日")
            let str1: String = HLCalendar.shareInstance.weekDayStrOfDate(date: cell.date!)
            
            selectDateBlcok!(cell.date!, "\(str0)\(str1)")
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}









