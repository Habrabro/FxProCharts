//
//  LightweightChartPriceFormatter.swift
//  FxProCharts
//
//  Created by admin on 31/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import Foundation
import LightweightCharts

class LightweightChartPriceFormatter {
    
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
    
    private var options: ChartOptions?
    
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
    
    init(withFormat format: FormatterType = .dollar, andSource source: SourceType = .js) {
        self.selectedFormat = format
        self.selectedSource = source
    }
    
    func applyToChart(_ chart: LightweightCharts) {
        guard let options = self.options else { return }
        chart.applyOptions(options: options)
    }
    
    private func updateFormatter() {
        let method: JavaScriptMethod<BarPrice>
        switch selectedSource {
        case .js:
            method = .javaScript(selectedFormat.formatterString)
        case .native:
            method = .closure(selectedFormat.formatterClosure)
        }
        options = ChartOptions(localization: LocalizationOptions(priceFormatter: method))
    }
}
