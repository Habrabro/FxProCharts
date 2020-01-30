//
//  LightweightChartView.swift
//  FxProCharts
//
//  Created by admin on 30/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit
import LightweightCharts

class LightweightChartView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var periodPicker: ChartPeriodPickerView!
    @IBOutlet weak var chart: LightweightCharts!
    
    var data: [LineData]? {
        didSet {
            displayingData = data
        }
    }
    var displayingData: [LineData]? {
        didSet {
            if let displayData = displayingData {
                series.setData(data: displayData)
                
            }
        }
    }
    
    private var series: LineSeries!
    
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
        Bundle.main.loadNibNamed("LightweightChartView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        periodPicker.delegate = self
        
        let options = ChartOptions(
            timeScale: TimeScaleOptions(timeVisible: true, secondsVisible: false)
        )
        chart.applyOptions(options: options)
        series = chart.addLineSeries(options: nil)
    }
    
    func rangeData(range: Periods) -> [LineData]? {
        guard let data = self.data else {
            return nil
        }
        var rangedData: [LineData] = []
        let startIndex = data.count - Int(range.timeInterval / DataProvider.shared.INTERVAL) - 1
        let stride = Int((range.timeInterval / DataProvider.shared.INTERVAL) / 50)
        if stride > 0 {
            for i in startIndex..<data.count {
                if i % stride == 0 {
                    rangedData.append(data[i])
                }
            }
        } else {
            rangedData = Array(data[startIndex..<data.count])
        }
        return rangedData
    }
}

extension LightweightChartView: PeriodPickerViewDelegate {
    
    func periodDidSelected(period: Periods) {
        displayingData = rangeData(range: period)
    }
}
