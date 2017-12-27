//
//  contactTxtField.swift
//  yoman
//
//  Created by רותם שיין on 18/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

class contactTxtField: UITextField {
    //make the UIText field under line only
    override func layoutSubviews() {
        super.layoutSubviews()
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
//        self.layer.borderColor = UIColor(white: 231/256, alpha:1).cgColor
//        self.layer.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds )
    }

   
}
