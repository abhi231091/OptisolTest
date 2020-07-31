//
//  Helper.swift
//  InfosysExercise_Abhi
//
//  Created by Abhishek Nagar on 08/07/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class Helper: NSObject {
    static let shared = Helper()
    private override init() {}

    func activityStartAnimating() {
        guard let windowView = UIWindow.key else {
            return
        }

        let backgroundView = UIView(frame: windowView.bounds)
        backgroundView.backgroundColor = .clear
        backgroundView.tag = 475647

        let squareView = UIView(frame: CGRect.init(x: 0, y: 0, width: 75, height: 75))
        squareView.center = windowView.center
        squareView.backgroundColor = UIColor.black
        squareView.alpha = 1.0
        squareView.layer.cornerRadius = 10
        squareView.clipsToBounds = true
        squareView.isUserInteractionEnabled = false

        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: squareView.frame.width/2-25, y: squareView.frame.width/2-25, width: 50, height: 50))
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
        }
        activityIndicator.color = UIColor.white
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        activityIndicator.startAnimating()
        squareView.addSubview(activityIndicator)
        backgroundView.addSubview(squareView)
        windowView.addSubview(backgroundView)
    }

    func activityStopAnimating() {
        guard let windowView = UIWindow.key else {
            return
        }

        if let background = windowView.viewWithTag(475647) {
            background.removeFromSuperview()
        }
    }
}
