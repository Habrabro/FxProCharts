//
//  DateValueFormatter.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    
    static let DEFAULT_DATE_FORMAT = "dd MMM HH:mm"
    
    private let dateFormatter = DateFormatter()
    
    private var format: String?
    
    override init() {
        super.init()
    }
    
    convenience init(format: String = DEFAULT_DATE_FORMAT) {
        self.init()
        self.format = format
        dateFormatter.dateFormat = format
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase? = nil) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
