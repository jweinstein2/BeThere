//
//  LineStats.swift
//  BeThere
//
//  Created by jared weinstein on 9/11/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import Charts

class LineStatView: LineChartView {
    var timeData : (onTime: Int, snoozed: Int, late: Int) = (12,1,3)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutViews()
    }
    
    private func layoutViews() {
        // Do any additional setup after loading the view.
        var titles = [""]
        var graphData = [0]
        
        var sum = 0
        for i in 1...200 {
            titles.append("")
            graphData.append(sum)
            sum += Int(arc4random()) % Int(20 / Int((i / 20) + 1)) + 3
        }
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<titles.count {
            let dataEntry = BarChartDataEntry(value: Double(graphData[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: nil)
        chartDataSet.lineWidth = 0.2
        chartDataSet.highlightLineWidth = 0.2
        let chartData = LineChartData(xVals: graphData, dataSets: [chartDataSet])
        self.data = chartData
        data?.setDrawValues(false)
        
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

