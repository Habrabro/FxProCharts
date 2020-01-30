//
//  DataProvider.swift
//  FxProCharts
//
//  Created by admin on 30/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import Foundation

class DataProvider {
    
    let INTERVAL: TimeInterval = 60
    
    var data: [Point]?
    
    static var shared: DataProvider = {
        let instance = DataProvider()
        return instance
    }()
    
    private init() {
        self.data = generateData(range: Periods.oneMonth.timeInterval)
    }
    
    private func generateData(range: TimeInterval) -> [Point] {
        let now = Date().timeIntervalSince1970
        let from = now - range
        let to = now
        
        let values = stride(from: from, to: to, by: INTERVAL).map { (x) -> Point in
            let y = Double.random(in: 0...1) + 1
            return Point(x: x, y: y)
        }
        
        return values
    }
}

extension DataProvider: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
