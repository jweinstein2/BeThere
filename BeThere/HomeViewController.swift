//
//  ViewController.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var streakLabel : UILabel!
    @IBOutlet var donatedLabel : UILabel!
    @IBOutlet var pointsLabel : UILabel!
    
    let user = MainModel.user

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        streakLabel.text = "\(user.streak)"
        donatedLabel.text = "$\(user.moneyDonated)"
        pointsLabel.text = "\(user.points)"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor(), NSFontAttributeName: UIFont(name: "avenir", size: 21)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    
    
    //MARK: TableViewDelegate methods


}

