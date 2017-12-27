//
//  menuViewController.swift
//  yoman
//
//  Created by רותם שיין on 14/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

class menuViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "phoneNumber")
        UserDefaults.standard.set(nil, forKey: "TaTtkn")
        
            performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contactUsButton(_ sender: Any) {
        performSegue(withIdentifier: "toContact", sender: Any?.self)
    }
    
}
