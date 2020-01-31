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
    
    enum SourceType: CaseIterable {
        case js
        case native
        
        var title: String {
            switch self {
            case .js:
                return "JavaScript"
            case .native:
                return "Swift"
            }
        }
    }
    
    enum FormatterType {
        case dollar
        case pound
        case custom(title: String, sign: String, digitsAfterDot: Int)
        
        var formatterString: String {
            switch self {
            case .dollar: return "function(price) { return '$' + price.toFixed(2); }"
            case .pound: return "function(price) { return '\u{00A3}' + price.toFixed(2); }"
            case let .custom(_, sign, digitsAfterDot): return "function(price) { return '\(sign)' + price.toFixed(\(digitsAfterDot)); }"
            }
        }
        
        var formatterClosure: (BarPrice) -> String {
            switch self {
            case .dollar: return { "🦄$\(($0 * 100).rounded() / 100)" }
            case .pound: return { "☁️\u{00A3}\(($0 * 100).rounded() / 100)" }
            default: return { _ in "-_-" }
            }
        }
        
        var title: String {
            switch self {
            case .dollar: return "Dollar"
            case .pound: return "Pound"
            case let .custom(title, _, _): return title
            }
        }
    }
    
    private var selectedFormat: FormatterType = .dollar {
        didSet {
            updateFormatter()
        }
    }
    private var selectedSource: SourceType = .js {
        didSet {
            updateFormatter()
        }
    }
    
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
                chart.timeScale().fitContent()
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
            layout: LayoutOptions(fontSize: 13),
            priceScale: PriceScaleOptions(
                borderVisible: false,
                entireTextOnly: true
            ),
            timeScale: TimeScaleOptions(
                borderVisible: false,
                timeVisible: true,
                secondsVisible: false
            ),
            grid: GridOptions(
                verticalLines: GridLineOptions(color: UIColor.black10.toHex),
                horizontalLines: GridLineOptions(color: UIColor.black10.toHex)
            )
        )
        chart.applyOptions(options: options)
        
        series = chart.addLineSeries(options: nil)
        selectedFormat = .custom(title: "SomeCurrency", sign: "", digitsAfterDot: 5)
    }
    
    func rangeData(range: Periods) -> [LineData]? {
        guard let data = self.data else {
            return nil
        }
        var rangedData: [LineData] = []
        let maximumXvaluesCount: Double = 120
        let startIndex: Int = {
            var index: Int = data.count - Int(range.timeInterval / DataProvider.shared.INTERVAL) - 1
            if index < 0 { index = 0 }
            return index
        }()
        let stride = Int((range.timeInterval / DataProvider.shared.INTERVAL) / maximumXvaluesCount)
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
    
    private func updateFormatter() {
        let method: JavaScriptMethod<BarPrice>
        switch selectedSource {
        case .js:
            method = .javaScript(selectedFormat.formatterString)
        case .native:
            method = .closure(selectedFormat.formatterClosure)
        }
        
        let options = ChartOptions(localization: LocalizationOptions(priceFormatter: method))
        chart.applyOptions(options: options)
    }
}

extension LightweightChartView: PeriodPickerViewDelegate {
    
    func periodDidSelected(period: Periods) {
        displayingData = rangeData(range: period)
    }
}
