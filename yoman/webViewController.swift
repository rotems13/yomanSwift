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
            let shadowPath = UIBezierPath()
            shadowPath.move(to: CGPoint(x: bottomLine.layer.bounds.origin.x, y: bottomLine.layer.frame.size.height))
            shadowPath.addLine(to: CGPoint(x: bottomLine.layer.bounds.width / 2, y: bottomLine.layer.bounds.height + 7.0))
            shadowPath.addLine(to: CGPoint(x: bottomLine.layer.bounds.width, y: bottomLine.layer.bounds.height))
            shadowPath.close()
            bottomLine.layer.shadowColor      = UIColor.black.cgColor
            bottomLine.layer.shadowOffset     = CGSize(width: 0, height: 1)
            bottomLine.layer.shadowRadius     = 4
            bottomLine.layer.shadowOpacity    = 0.2
            bottomLine.layer.zPosition        = 25
            bottomLine.layer.shadowPath       = shadowPath.cgPath
            bottomLine.layer.masksToBounds    = false
            
        }
    }
    @IBOutlet weak var titleAcount: UILabel!{
        didSet{
            titleAcount.text = acount.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start WEBVIEWWWW**************************************")
        print(acount.siteURL)
        let Realurl = NSURL(string: acount.siteURL)

        let request = URLRequest(url: Realurl! as URL )
        webView.load(request)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
