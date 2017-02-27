//
//  ViewController.swift
//  HlCalendar-Swift
//
//  Created by HL on 17/2/25.
//  Copyright © 2017年 花磊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monthesNum: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    var selectDate: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnClickAction(_ sender: Any) {
        
        let vc: HLCalendarVC = HLCalendarVC()
        vc.montherNum = Int(monthesNum.text!)
        vc.selectDate = selectDate != nil ? selectDate! : Date()
//        vc.selectDateBlcok = ({
//            [unowned self] (date: Date, dateStr: String) -> () in
//            
//            self.selectDate = date
//            self.btn.setTitle(dateStr, for: .normal)
//        })
        
        vc.didSelectDate { [unowned self] (date: Date, dateStr: String) in
            self.selectDate = date
            self.btn.setTitle(dateStr, for: .normal)
        }
        
        let naviVC: UINavigationController = UINavigationController(rootViewController: vc)
        present(naviVC, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

