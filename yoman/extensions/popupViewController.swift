//
//  popupViewController.swift
//  yoman
//
//  Created by רותם שיין on 18/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func displayMsg(title : String?, msg : String,
                    style: UIAlertControllerStyle = .alert,
                    dontRemindKey : String? = nil) {
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: style)
        ac.view.tintColor = UIColor.blue
        ac.addAction(UIAlertAction.init(title: "בסדר", style: .default, handler: nil))
    
        
        if dontRemindKey != nil {
            ac.addAction(UIAlertAction.init(title: "Don't Remind",
                                            style: .default, handler: { (aa) in
                                                UserDefaults.standard.set(true, forKey: dontRemindKey!)
                                                UserDefaults.standard.synchronize()
            }))
        }
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
            
        }
    }
    func internetAlert() -> Bool{
        if(!internetConnection){
            displayMsg(title: "בעיית חיבור לאינטרנט", msg: "כדי להמשיך, עלייך להתחבר לאינטרנט")
            return false
            
        }
        return true
    
    }
    func createShadow(view: UIView){
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: view.layer.bounds.origin.x, y: view.layer.frame.size.height))
        shadowPath.addLine(to: CGPoint(x: view.layer.bounds.width / 2, y: view.layer.bounds.height + 7.0))
        shadowPath.addLine(to: CGPoint(x: view.layer.bounds.width, y: view.layer.bounds.height))
        shadowPath.close()
        view.layer.shadowColor      = UIColor.black.cgColor
        view.layer.shadowOffset     = CGSize(width: 0, height: 1)
        view.layer.shadowRadius     = 4
        view.layer.shadowOpacity    = 0.2
        view.layer.zPosition        = 25
        view.layer.shadowPath       = shadowPath.cgPath
        view.layer.masksToBounds    = false
    }
    func goToWelcome(){
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "welcomeScreen") as! welcomeScreen
        self.present(viewController, animated: false, completion: nil)
    }
    func goToAcounts(){
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "accounts") as! AccountsCollectionViewController
        self.present(viewController, animated: false, completion: nil)
    }
    func goToFutureEvent(){
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "futureEvents") as! FutureEvent
        self.present(viewController, animated: false, completion: nil)
    }
    func goToWebView(){
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "webView") as! webViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
}

