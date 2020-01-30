//
//  LineChartStyler.swift
//  FxProCharts
//
//  Created by admin on 30/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit
import Charts

class LineChartStyler {
    
    func style(_ lineChartView: LineChartView) {
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        lineChartView.noDataTextColor = .clear
        
        let xAxis = lineChartView.xAxis
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.drawLabelsEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.systemFont(ofSize: 13)
        xAxis.labelTextColor = UIColor.black38
        xAxis.gridColor = UIColor.black10
        xAxis.granularityEnabled = true
        xAxis.granularity = UIScreen.main.bounds.width < 375 ? 25 : 20
        xAxis.valueFormatter = DateValueFormatter(format: "HH:mm")
        
        let rightAxis = lineChartView.rightAxis
        rightAxis.drawAxisLineEnabled = false
        rightAxis.labelFont = UIFont.systemFont(ofSize: 13)
        rightAxis.labelTextColor = UIColor.black38
        rightAxis.gridColor = UIColor.black10
        
        guard let dataSet = lineChartView.lineData?.dataSets.first as? LineChartDataSet else { return }
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.lineWidth = 2.0
        dataSet.highlightEnabled = false
        dataSet.colors = [UIColor.blue]
    }
    
}
