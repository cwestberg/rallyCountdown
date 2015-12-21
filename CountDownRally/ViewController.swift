//
//  ViewController.swift
//  CountDownRally
//
//  Created by Clarence Westberg on 12/21/15.
//  Copyright © 2015 Clarence Westberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catNumberLbl: UILabel!
    @IBOutlet weak var todLbl: UILabel!
    @IBOutlet weak var dueTimeLbl: UILabel!
    @IBOutlet weak var dueTimeDeltaLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var timer = NSTimer()
    var timeUnit = "seconds"
    var delta = 0
    var currentDueTime = NSDate()
    var carNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
            selector: "updateTimeLabel", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func carNumberBtn(sender: AnyObject) {
    }
    
    @IBAction func addTimeBtn(sender: AnyObject) {
    }
    
    func updateTimeLabel() {
        
        catNumberLbl.text = String(carNumber)
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
        
        print("second = \(dateComponents.second)")
        
        
        let unit = Double(dateComponents.second)
        let second = Int(unit)
        let secondString = String(format: "%02d", second)
        
        let cent = Int((unit * (1.6667)))
        let centString = String(format: "%02d", cent)
        let minuteString = String(format: "%02d", dateComponents.minute)
        switch timeUnit {
        case "seconds":
            todLbl.text = "\(dateComponents.hour):\(minuteString):\(secondString)"
        case "cents":
            todLbl.text = "\(dateComponents.hour):\(minuteString).\(centString)"
        default:
            break;
        }
        
//        current due time o current time
        dueTimeDeltaLbl.text = "0"
        

    }
}

