//
//  label.swift
//  yoman
//
//  Created by רותם שיין on 21/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

class label: UILabel {
    

}

extension UILabel{
    func adjust(label : UILabel){
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label .minimumScaleFactor = 0.5
    }
    
}
