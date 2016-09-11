//
//  ViewController.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import UIKit

class EventCell : UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}

class HomeViewController: UIViewController {
    @IBOutlet var streakLabel : UILabel!
    @IBOutlet var donatedLabel : UILabel!
    @IBOutlet var pointsLabel : UILabel!
    
    @IBOutlet var weekButtons: [UIButton]!
    @IBOutlet var dayEventTable : UITableView!
    
    var selectedDay = 1
    let user = MainModel.user
    var events : [Event] = MainModel.events

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        streakLabel.text = "\(user.streak)"
        donatedLabel.text = "$\(user.moneyDonated)"
        pointsLabel.text = "\(user.points)"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor(), NSFontAttributeName: UIFont(name: "avenir", size: 21)!]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onEventsUpdated(_:)), name: "eventsUpdated", object: nil)
        
        //TableViewCustomization
        dayEventTable.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onEventsUpdated(notification: NSNotification) {
        events = MainModel.events
        dayEventTable.reloadData()
    }
    
    //MARK: Actions
    @IBAction func weekdayPressed(sender: UIButton) {
        let daysDict = [0 : "monday", 1 : "tuesday", 2 : "wednesday", 3 : "thursday", 4: "friday", 5 : "saturday", 6 : "sunday"]
        
        for i in 0..<weekButtons.count {
            var button = weekButtons[i]
            if button == sender {
                let imageName = "\(daysDict[i]!)_color"
                sender.setImage(UIImage(named: imageName), forState: .Normal)
            } else {
                let imageName = "\(daysDict[i]!)_white"
                button.setImage(UIImage(named: imageName), forState: .Normal)
            }
        }
    }
    


}

//MARK: TableViewDelegate methods
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return events.count
    }
    
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let index = indexPath.row
        let event = events[index]
        let cell = self.dayEventTable.dequeueReusableCellWithIdentifier("eventCell") as! EventCell
        //let proj = projectList[indexPath.row]
        
        cell.titleLabel.text = event.name
        cell.locationLabel.text = event.locationString
        cell.timeLabel.text = "11:35 AM" //TODO: Complete this correctly
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let event = events[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("eventViewController") as! EventViewController
        vc.event = event
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
        return 95
    }
}

