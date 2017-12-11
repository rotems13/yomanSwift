//
//  loginViewController.swift
//  yoman
//
//  Created by רותם שיין on 23/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import Foundation
import Alamofire


let defaults = UserDefaults.standard

class loginViewController: UITableViewController {
    @IBOutlet weak var progressBar: UIActivityIndicatorView!{
        didSet{
            progressBar.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var edPhonenumber: UITextField!
    @IBAction func SubmitNumber(_ sender: Any) {
      
        let phoneNumber:String! = edPhonenumber.text
        defaults.set(phoneNumber, forKey: "phoneNumber")
        toggleProgress(show: true)

        let queue = OperationQueue()
        queue.addOperation {
            let semaphore = DispatchSemaphore(value: 0)
            
        let parameters: Parameters = ["mobileNumber": phoneNumber!]
        var loginURL = "https://mdev1.yoman.co.il/api/Client/Login"

        AlmofireService.getData(url: loginURL, method: .post, parameters: parameters, headers: nil) { responseObject, error in
            let logtkn =  self.parseToken(json: responseObject!)
            
            defaults.set(logtkn, forKey: "loginTkn")
            semaphore.wait();
            }
            semaphore.signal();
            if(loginTkn != nil){
                DispatchQueue.main.async{
                    self.goToNextView()
                }
            }
        }
    }
    
    func goToNextView() {
        performSegue(withIdentifier: "toVerify", sender: self)
    }

    func toggleProgress(show:Bool){
        show ? progressBar.startAnimating() : progressBar.stopAnimating()
    }
    func parseToken(json : [String:Any]) -> String! {
        let thedata = json["data"]as? [String: Any]
        let loginTkn = thedata!["token"]as? String
        return loginTkn
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start Login**************************************")
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
