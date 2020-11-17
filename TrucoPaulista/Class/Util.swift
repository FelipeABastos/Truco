//
//  Util.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 11/11/20.
//

import Foundation
import UIKit
import RKDropdownAlert

class Util {
    
    static func showMessage(title: String?, message: String?, type : MessageType) {
        
        var backgroundColor: UIColor?
        var textColor: UIColor?
        
        switch type {
            
        case .success:
            backgroundColor = UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0)
            textColor = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.0)
            break
            
        case .warning:
            backgroundColor = UIColor(red:1.00, green:0.78, blue:0.02, alpha:1.0)
            textColor = UIColor(red:0.36, green:0.14, blue:0.08, alpha:1.0)
            break
            
        case .error:
            backgroundColor = UIColor(red:0.88, green:0.10, blue:0.19, alpha:1.0)
            textColor = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.0)
            break
        }
        
        RKDropdownAlert.title(title, message: message, backgroundColor: backgroundColor, textColor: textColor)
    }
}
