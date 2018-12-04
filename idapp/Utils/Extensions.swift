//
//  Extensions.swift
//  idapp
//
//  Created by Ignacio Hernández ٩(●̮̮̃•̃)۶ on 18/08/18.
//  Copyright © 2018 Ignacio. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension UIButton
extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(kCTUnderlineStyleAttributeName as NSAttributedStringKey, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


//MARK: - Extension UIColor
extension UIColor{
    class func grisCeldaPago() -> UIColor{
        return UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
    }
    
    class func grisDetallePago() -> UIColor{
        return UIColor(red: 171/255.0, green: 171/255.0, blue: 171/255.0, alpha: 1.0)
    }
    
    class func azulBordeCheck() -> UIColor{
        return UIColor(red: 17/255.0, green: 80/255.0, blue: 174/255.0, alpha: 1.0)
    }
    
}
