//
//  PeriodPicker.swift
//  FxProCharts
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

enum Periods: String, RawRepresentable {
    
    case oneMinute = "1 M"
    case fiveMinutes = "5 M"
    case fifteenMinutes = "15 M"
    case thirtyMinutes = "30 M"
    case oneHour = "1 H"
    case twoHours = "2 H"
    case fourHours = "4 H"
    case twelveHours = "12 H"
    case oneDay = "1 D"
    case oneWeek = "1 W"
    case oneMonth = "1 MN"
}

extension Periods {
    
    var timeInterval: TimeInterval {
        let minuteSeconds = 60
        let hourSeconds = 3600
        let daySeconds = hourSeconds * 24
        let weekSeconds = daySeconds * 7
        let monthSeconds = weekSeconds * 4
        switch self {
        case .oneMinute: return TimeInterval(minuteSeconds)
        case .fiveMinutes: return TimeInterval(minuteSeconds * 5)
        case .fifteenMinutes: return TimeInterval(minuteSeconds * 15)
        case .thirtyMinutes: return TimeInterval(minuteSeconds * 30)
        case .oneHour: return TimeInterval(hourSeconds)
        case .twoHours: return TimeInterval(hourSeconds * 2)
        case .fourHours: return TimeInterval(hourSeconds * 4)
        case .twelveHours: return TimeInterval(hourSeconds * 12)
        case .oneDay: return TimeInterval(daySeconds)
        case .oneWeek: return TimeInterval(weekSeconds)
        case .oneMonth: return TimeInterval(monthSeconds)
        }
    }
}

class ChartPeriodPickerView: UIView {
    
    // MARK: Public properties
    
    var delegate: PeriodPickerViewDelegate?
    var data: [PeriodPickerCollectionViewCellModel] = [
        PeriodPickerCollectionViewCellModel(period: .oneMinute),
        PeriodPickerCollectionViewCellModel(period: .fiveMinutes),
        PeriodPickerCollectionViewCellModel(period: .fifteenMinutes),
        PeriodPickerCollectionViewCellModel(period: .thirtyMinutes),
        PeriodPickerCollectionViewCellModel(period: .oneHour),
        PeriodPickerCollectionViewCellModel(period: .twoHours),
        PeriodPickerCollectionViewCellModel(period: .fourHours),
        PeriodPickerCollectionViewCellModel(period: .twelveHours),
        PeriodPickerCollectionViewCellModel(period: .oneDay),
        PeriodPickerCollectionViewCellModel(period: .oneWeek),
        PeriodPickerCollectionViewCellModel(period: .oneMonth),
    ]
    var expanded: Bool = false {
        didSet {
            if (expanded) {
                UIView.animate(withDuration: 0.2) {
                    self.trailingPeriodPickerConstraint?.isActive = false
                    self.leadingPeriodPickerConstraint?.isActive = true
                    self.contentView.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.trailingPeriodPickerConstraint?.isActive = true
                    self.leadingPeriodPickerConstraint?.isActive = false
                    self.contentView.layoutIfNeeded()
                }
            }
        }
    }
    
    // Private properties
    
    private var periodPickerCollectionViewDataSource: PeriodPickerCollectionViewDataSource!
    
    // Outlets
    
    @IBOutlet weak var periodPicker: UIView!
    @IBOutlet weak var selectPeriodButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var periodPickerTrailingConstraint: NSLayoutConstraint!
    
    @IBAction func selectPeriodButtonDidTapped(_ sender: Any) {
        expanded = !expanded
    }
    
    var trailingPeriodPickerConstraint: NSLayoutConstraint?
    var leadingPeriodPickerConstraint: NSLayoutConstraint?
    
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
        Bundle.main.loadNibNamed("ChartPeriodPickerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        trailingPeriodPickerConstraint = periodPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        leadingPeriodPickerConstraint = periodPicker.trailingAnchor.constraint(equalTo: selectPeriodButton.trailingAnchor)
        trailingPeriodPickerConstraint?.isActive = true
        
        configure()
    }
    
    func configure() {
        collectionView.delegate = self
        periodPickerCollectionViewDataSource = PeriodPickerCollectionViewDataSource(data: data, collectionView: collectionView)
        collectionView.reloadData()
    }
    
    func periodDidSelected(period: Periods) {
        selectPeriodButton.setTitle(period.rawValue, for: .normal)
        delegate?.periodDidSelected(period: period)
    }
    
}

// MARK: UICollectionViewDelegate extension

extension ChartPeriodPickerView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        periodDidSelected(period: model.period)
        expanded = true
    }

}

// MARK: UICollectionViewDelegateFlowLayout extension

extension ChartPeriodPickerView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = periodPickerCollectionViewDataSource.cell(forCollectionView: collectionView, atIndexPath: indexPath) as! PeriodPickerCollectionViewCell
        return cell.cellSize
    }

}
