//
//  Common.swift
//  HlCalendar-Swift
//
//  Created by HL on 17/2/26.
//  Copyright © 2017年 花磊. All rights reserved.
//

import UIKit

let WHITE_COLOR: UIColor = UIColor.white

let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width

let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height

let MAIN_COLOR: UIColor = UIColor.init(colorLiteralRed: 0.0 / 255.0, green: 160.0 / 255.0, blue: 220.0 / 255.0, alpha: 1)

func COLOR(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor.init(colorLiteralRed: Float(r / 255.0), green: Float(g / 255.0), blue: Float(b / 255.0), alpha: Float(a))
}
