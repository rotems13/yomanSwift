//
//  welcomeScreen.swift
//  yoman
//
//  Created by רותם שיין on 22/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

class welcomeScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ((TaTtkn != nil) && (phoneNumber != nil)) {
            performSegue(withIdentifier: "toAccounts", sender: Any?.self)
        }
    }
    
    @IBAction func nextScreen(_ sender: UIButton) {
            performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gradient() ->Void {
        let topColor = UIColor(red: 248/255, green: 105/255, blue: 134/255, alpha: 1)
        let bottomColor = UIColor(red: 238/255, green: 56/255, blue: 78/255, alpha: 1)
        let gradientColor: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
