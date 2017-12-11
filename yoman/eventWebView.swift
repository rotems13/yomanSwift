
//
//  eventWebView.swift
//  yoman
//
//  Created by רותם שיין on 07/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import WebKit


class eventWebView: UIViewController {
    @IBOutlet weak var webViewEvent: WKWebView!
 
   
    
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "toEvents", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Realurl = NSURL(string: event.Url)
        
        let request = URLRequest(url: Realurl! as URL )
        webViewEvent.load(request)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
