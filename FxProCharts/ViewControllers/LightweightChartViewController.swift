//
//  LightweightChartViewController.swift
//  FxProCharts
//
//  Created by admin on 30/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit
import LightweightCharts

class LightweightChartViewController: UIViewController {
    
    @IBOutlet weak var lightweightChartView: LightweightChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateValueFormatter = DateValueFormatter(format: "yyyy-MM-dd")
        let lineData = DataProvider.shared.data!.map { (point: Point) -> LineData in
            let data = LineData(time: .utc(timestamp: point.x), value: point.y)
            return data
        }
        lightweightChartView.data = lineData
    }

}
