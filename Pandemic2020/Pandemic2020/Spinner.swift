//
//  Spinner.swift
//  Pandemic2020
//
//  Created by Shilpa S on 04/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import UIKit

class Spinner: UIView {
    
    static let shared = Spinner()

    private var activityIndicator: UIActivityIndicatorView!
    
    
    private init() {
        super.init(frame : .zero)
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        self.backgroundColor = UIColor.white
        //Align center
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(onView parentView: UIView) {
        self.frame = parentView.bounds
        parentView.addSubview(self)
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
    
    
}
