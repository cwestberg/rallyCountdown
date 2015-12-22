//
//  ViewController.swift
//  CountDownRally
//
//  Created by Clarence Westberg on 12/21/15.
//  Copyright © 2015 Clarence Westberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

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
    var items: [String] = []

    
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

    @IBAction func addTimeBtn(sender: AnyObject) {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "Due Time", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
            
        }
        actionSheetController.addAction(cancelAction)
        
        //Create and an start action
        let startAction: UIAlertAction = UIAlertAction(title: "Add", style: .Default) { action -> Void in
            //Do some other stuff
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ";
            let defaultTimeZoneStr = formatter.stringFromDate(date)
            formatter.timeZone = NSTimeZone(abbreviation: "-600");

            print("defaultTimeZoneStr \(defaultTimeZoneStr)")

            let hours = actionSheetController.textFields![0]
            let minutes = actionSheetController.textFields![1]
            let units = actionSheetController.textFields![2]
            
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            let hh = (hours.text!).stringByReplacingOccurrencesOfString("HH ",withString: "")
            let mm = (minutes.text!).stringByReplacingOccurrencesOfString("MM ",withString: "")
            let uu = (units.text!).stringByReplacingOccurrencesOfString("UU ",withString: "")
            print("\(hh):\(mm):\(uu)")

            let str = "2015-12-21 \(hh):\(mm):\(uu) -600"
            print("str \(str)")
            self.dueTimeLbl.text = str
            
            let someDateTime = formatter.dateFromString(str)
            print("\(someDateTime)")
            print("HH: \(hours.text!) MM: \(minutes.text!) UU: \(units.text!)")
            self.items.insert(str, atIndex:0)
            self.tableView.reloadData()
        }
        actionSheetController.addAction(startAction)
        
        
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            textField.text = "HH \(dateComponents.hour)"
            textField.textColor = UIColor.blueColor()
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            textField.text = "MM \(dateComponents.minute + 1)"
            textField.textColor = UIColor.blueColor()
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            textField.text = "UU 00"
            textField.textColor = UIColor.blueColor()
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }


    @IBAction func carNumberBtn(sender: AnyObject) {
    }
    

    func updateTimeLabel() {
        
        catNumberLbl.text = String(carNumber)
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
        
//        print("second = \(dateComponents.second)")
        
        
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
    // Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
//        showAlertTapped(indexPath.row)
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    // End Table
}

