//
//  CalendarHeaderCRV.swift
//  HlCalendar-Swift
//
//  Created by HL on 17/2/26.
//  Copyright © 2017年 花磊. All rights reserved.
//

import UIKit

class CalendarHeaderCRV: UICollectionReusableView {
    
    let monthLab: UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 25))
        lab.textAlignment = NSTextAlignment.center
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(colorLiteralRed: 239.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        
        self.addSubview(monthLab)
        
        let weekDays: NSArray = ["日", "一", "二", "三", "四", "五", "六"]
        
        let labW: CGFloat = SCREEN_WIDTH / 7.0
        
        let labH: CGFloat = 25.0
        
        let y: CGFloat = 25.0
        
        for i in 0..<7 {
            let lab: UILabel = UILabel(frame: CGRect(x: CGFloat(i) * labW, y: y, width: labW, height: labH))
            lab.font = UIFont.systemFont(ofSize: 13.0)
            lab.textAlignment = .center
            if i == 0 || i == 6 {
                lab.textColor = COLOR(r: 35, g: 182, b: 245, a: 1.0)
            } else {
                lab.textColor = UIColor.black
            }
            lab.text = weekDays[i] as? String
            self.addSubview(lab)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
