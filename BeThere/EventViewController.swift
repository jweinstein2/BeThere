//
//  eventViewController.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit
import Charts

class RepeatCell : UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}


class EventViewController: UIViewController {
    var event : Event!

    @IBOutlet weak var barChart: BarStatView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var repeatTable: UITableView!
    @IBOutlet weak var multiplierLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var donatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationLabel.text = "\(event.locationString)"
        donatedLabel.text = "$\(event.moneyDonated)"
        streakLabel.text = "\(event.streak)"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "avenir", size: 21)!]
        
        //TableViewCustomization
        repeatTable.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
}

//MARK: TableViewDelegate methods
extension EventViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //let index = indexPath.row
        //let data = events[index]
        let cell = self.repeatTable.dequeueReusableCellWithIdentifier("repeatCell") as! RepeatCell
        
        cell.timeLabel.text = "9:00 PM"
        cell.dayLabel.text = "MON"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
        return 95;
    }
}
