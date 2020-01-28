//
//  ActionExtension.swift
//  FxProCharts
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit

final class ActionTap: NSObject {
    private var _tap: (_ sender: UITapGestureRecognizer) -> ()
    
    init (block: @escaping (_ sender: UITapGestureRecognizer) -> ()) {
        _tap = block
        super.init()
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        _tap(sender)
    }
}

final class ActionClick: NSObject {
    private var _click: (_ sender: UIButton) -> ()
    
    init (block: @escaping (_ sender: UIButton) -> ()) {
        _click = block
        super.init()
    }
    
    @objc func click(sender: UIButton) {
        _click(sender)
    }
}

protocol Actionable: class { }

extension UIView: Actionable {
    fileprivate struct CustomProperties {
        static var _actionTap: ActionTap?
        static var _actionClick: ActionClick?
    }
    
    fileprivate func _getAssociatedObject<T>(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}

extension Actionable where Self: UIView {
    var actionTap: ActionTap? {
        get {
            return _getAssociatedObject(&CustomProperties._actionTap, defaultValue: CustomProperties._actionTap)
        }
        set {
            objc_setAssociatedObject(self, &CustomProperties._actionTap, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            let tap = UITapGestureRecognizer.init(target: self.actionTap, action: #selector(self.actionTap?.tap(sender:)))
            self.addGestureRecognizer(tap)
            self.isUserInteractionEnabled = true
        }
    }
    
    func tap(_ selector: Selector) {
        guard let target = self.parentViewController else {return}
        if self.gestureRecognizers?.first(where: {$0 is UITapGestureRecognizer}) == nil {
            let tap = UITapGestureRecognizer(target: target, action: selector)
            self.addGestureRecognizer(tap)
            self.isUserInteractionEnabled = true
        }
    }
}

extension Actionable where Self: UIButton {
    var actionClick: ActionClick? {
        get {
            return _getAssociatedObject(&CustomProperties._actionClick, defaultValue: CustomProperties._actionClick)
        }
        set {
            objc_setAssociatedObject(self, &CustomProperties._actionClick, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.addTarget(self.actionClick, action: #selector(self.actionClick?.click(sender:)), for: .touchUpInside)
        }
    }
    
    func click(_ selector: Selector) {
        guard let target = self.parentViewController else {return}
        if self.actions(forTarget: target, forControlEvent: .touchUpInside) == nil {
            self.addTarget(target, action: selector, for: .touchUpInside)
        }
    }
}
