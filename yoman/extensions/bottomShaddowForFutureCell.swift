//
//  bottomShaddowForFutureCell.swift
//  yoman
//
//  Created by רותם שיין on 27/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

class bottomShaddowForFutureCell: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: self.layer.bounds.minX, y:self.layer.bounds.maxY ))
        shadowPath.addLine(to: CGPoint(x: self.layer.bounds.maxX, y: self.layer.bounds.maxY ))
        shadowPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shadowPath.cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1.5
        
        self.layer.addSublayer(shapeLayer)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
