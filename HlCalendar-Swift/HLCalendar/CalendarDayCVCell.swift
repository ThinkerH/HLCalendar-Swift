//
//  CalendarDayCVCell.swift
//  HlCalendar-Swift
//
//  Created by HL on 17/2/26.
//  Copyright © 2017年 花磊. All rights reserved.
//

import UIKit

class CalendarDayCVCell: UICollectionViewCell {
    
    var backView: UIView?
    
    var dayLab: UILabel?
    
    var chineseLab: UILabel?
    
    var date: Date?
    
    var isSelect: Bool = false
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backView?.layer.cornerRadius = 4.0
        backView?.layer.masksToBounds = true
        backView?.backgroundColor = WHITE_COLOR
        
        dayLab = UILabel(frame: CGRect(x: 0, y: 4, width: frame.size.width, height: 20))
        dayLab?.textColor = UIColor.black
        dayLab?.font = UIFont.systemFont(ofSize: 15.0)
        dayLab?.textAlignment = .center
        
        chineseLab = UILabel(frame: CGRect(x: 0, y: (dayLab?.frame.maxY)!, width: frame.size.width, height: 20))
        chineseLab?.textColor = COLOR(r: 165.0, g: 177.0, b: 188.0, a: 1.0)
        chineseLab?.font = UIFont.systemFont(ofSize: 12.0)
        chineseLab?.textAlignment = .center
        
        self.addSubview(backView!)
        self.addSubview(dayLab!)
        self.addSubview(chineseLab!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
