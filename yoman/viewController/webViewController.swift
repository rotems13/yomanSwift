//
//  webViewController.swift
//  yoman
//
//  Created by רותם שיין on 29/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import WebKit



class webViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
   
    @IBOutlet weak var bottomLine: UIView!{
        didSet{
           createShadow(view: bottomLine)
        }
    }
    @IBAction func goToDescription(_ sender: Any) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "description") as! descriptionEvent
         self.present(viewController, animated: false, completion: nil)
    }
    @IBOutlet weak var titleAcount: UILabel!{
        didSet{
            titleAcount.text = acount.title
        }
    }
    @IBAction func backToAccount(_ sender: Any) {
        dismiss(animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        if (!internetAlert()){
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "welcomeScreen") as! welcomeScreen
            self.present(viewController, animated: false, completion: nil)        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Realurl = NSURL(string: acount.siteURL)
        let request = URLRequest(url: Realurl! as URL )
        webView.load(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
