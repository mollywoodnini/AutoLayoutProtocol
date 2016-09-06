//
//  AutoLayoutProtocol.swift
//  CoinFlip
//
//  Created by Tan Nghia La on 04.07.16.
//  Copyright © 2016 Tan Nghia La. All rights reserved.
//

import Foundation
import UIKit

protocol AutoLayoutProtocol: class {
    var views: [String: UIView] {get set}
    var alConstraints: [NSLayoutConstraint] {get set}
    
    func configureView()
    func configureConstraints()
}

extension AutoLayoutProtocol where Self:UIView {
    func addALSubview(view: UIView) {
        addALSubview(view: view, toView: self)
    }
    
    func addALSubview(view: UIView, toView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        views[propertyNameFor(view: view)] = view
        toView.addSubview(view)
    }
}

extension AutoLayoutProtocol where Self:UIViewController {
    func addALSubview(view: UIView, toView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        views[propertyNameFor(view: view)] = view
        toView.addSubview(view)
    }
}

extension AutoLayoutProtocol {
    func appendConstraints(withVisualFormat visualFormat: String, options: NSLayoutFormatOptions = [], metrics: [String: CGFloat]? = nil) {
        alConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: options, metrics: metrics, views: views))
    }
}

extension NSObject {
    func propertyNameFor(view: UIView) -> String {
        let mirror = Mirror(reflecting: self)
        
        guard let name = mirror.children.filter({$0.value as? UIView == view}).first?.label else {
            fatalError("[AutoLayoutProtocol][propertyNameFor]: View is not in the view hierarchy")
        }
        
        return name
    }
}
