//
//  ChartView.swift
//  FxProCharts
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit
import Charts

class ChartView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var chartViewPeriodPicker: ChartPeriodPickerView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    // MARK: Initializers
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    
        commonInit()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ChartView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        chartViewPeriodPicker.delegate = self
        
        let values = DataProvider.shared.data!.map { ChartDataEntry(x: $0.x, y: $0.y) }
        setData(values)
        
        let lineChartStyler = LineChartStyler()
        lineChartStyler.style(lineChartView)
        setRange(to: Periods.oneMinute)
    }
    
    // Private methods
    
    private func setData(_ data: [ChartDataEntry]) {
        let dataSet = LineChartDataSet(entries: data, label: "dataset")
        lineChartView.data = LineChartData(dataSet: dataSet)
    }
    
    private func setRange(to period: Periods) {
        let now = Date().timeIntervalSince1970
        let interval = period.timeInterval
        lineChartView.resetViewPortOffsets()
        lineChartView.moveViewToX(now - interval)
        lineChartView.setVisibleXRangeMaximum(interval)
        
    }
}

extension ChartView: PeriodPickerViewDelegate {
    
    func periodDidSelected(period: Periods) {
        setRange(to: period)
    }
    
}
