//
//  BarStats.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import UIKit
import Charts

class BarStatView: BarChartView{
    var timeData : (onTime: Int, snoozed: Int, late: Int) = (12,1,3)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutViews()
    }
    
    private func layoutViews() {
        // Do any additional setup after loading the view.
        let titles = ["On Time", "Snoozed", "Late"]
        //let graphData = [timeData.onTime, timeData.snoozed, timeData.late]
        let graphData = [Int(arc4random() % 20) + 10, Int(arc4random() % 10), Int(arc4random() % 10)]
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<titles.count {
            let dataEntry = BarChartDataEntry(value: Double(graphData[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let dataset = BarChartDataSet(yVals: dataEntries, label: "")
        let data = BarChartData(xVals: titles, dataSet: dataset)
        self.data = data
        data.setDrawValues(false)
        
        //self.leftAxis.drawLimitLinesBehindDataEnabled = true
        self.leftAxis.enabled = false
        self.rightAxis.enabled = false
        //self.xAxis.enabled = false
        self.legend.enabled = false
        self.drawGridBackgroundEnabled = false
        self.drawBordersEnabled = false
        self.animate(yAxisDuration: 0.6)
        
        self.xAxis.labelFont = UIFont(name: "Avenir Next", size: 15)!
        self.xAxis.labelPosition = .Bottom
        self.xAxis.labelTextColor = UIColor.whiteColor()
        
        //Set axis min
        //self.leftAxis.axisMaxValue = 5.5
        //self.leftAxis.axisMinValue = 0.5
        
        self.highlighter = nil
        
        self.extraLeftOffset = 0
        self.extraRightOffset = 0
        self.extraTopOffset = 5
        self.extraBottomOffset = 5
        self.descriptionText = ""
        self.minOffset = 0
        
        
        //Disable Scrolling and Zooming
        self.scaleYEnabled = false
        self.scaleXEnabled = false
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        
        self.fitScreen()
    }
}
