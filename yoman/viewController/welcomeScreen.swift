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
        print("welcome screen")
        gradient()                  //do two colors gradient
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // if user logged in --> go to accounts
        if(internetAlert()){
            if ((TaTtkn != nil) && (phoneNumber != nil))
            {
                let viewController = self.storyboard!.instantiateViewController(withIdentifier: "accounts") as! AccountsCollectionViewController
                
                self.present(viewController, animated: false, completion: nil)
            }

        }
    }
    // not logged in --> go to log in 
    @IBAction func nextScreen(_ sender: UIButton) {
        if (internetAlert()){
        performSegue(withIdentifier: "toLogin", sender: self)
        }
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
