//
//  Extensions.swift
//  MovieDatabase
//
//  Created by Joseph Lee on 11/30/19.
//  Copyright © 2019 Joseph Lee. All rights reserved.
//

import UIKit

var loadingView: UIView?

extension UIViewController {
    
    func showSpinner() {
        loadingView = UIView(frame: self.view.bounds)
        loadingView!.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = loadingView!.center
        indicator.startAnimating()
        loadingView!.addSubview(indicator)
        view.addSubview(loadingView!)
    }
    
    func removeSpinner() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}
