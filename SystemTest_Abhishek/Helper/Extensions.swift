//
//  Extensions.swift
//  InfosysExercise_Abhi
//
//  Created by Abhishek Nagar on 20/07/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import UIKit
// MARK: - UIWindow
 extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

// MARK: - String
extension String {

  //MARK:- Convert UTC To Local Date by passing date formats value
  func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = incomingFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

    let dt = dateFormatter.date(from: self)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = outGoingFormat

    return dateFormatter.string(from: dt ?? Date())
  }

  //MARK:- Convert Local To UTC Date by passing date formats value
//  func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = incomingFormat
//    dateFormatter.calendar = NSCalendar.current
//    dateFormatter.timeZone = TimeZone.current
//
//    let dt = dateFormatter.date(from: self)
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//    dateFormatter.dateFormat = outGoingFormat
//
//    return dateFormatter.string(from: dt ?? Date())
//  }
}
