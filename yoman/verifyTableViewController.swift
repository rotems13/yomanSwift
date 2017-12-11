//
//  verifyTableViewController.swift
//  yoman
//
//  Created by רותם שיין on 27/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire

let phoneNumber = defaults.string(forKey: "phoneNumber")
let loginTkn = defaults.string(forKey: "loginTkn")

class verifyTableViewController: UITableViewController {
    var jsonItem:JSON = JSON()
    @IBOutlet weak var progressBar: UIActivityIndicatorView!{
        didSet{
            progressBar.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var edVerifyNumber: UITextField!
    @IBAction func submitVerifyNumber(_ sender: Any) {
        toggleProgress(show: true)
        let tempPass = edVerifyNumber.text
        toggleProgress(show: true)

        let queue = OperationQueue()
        queue.addOperation {
            let semaphore = DispatchSemaphore(value: 0)
        
            let parameters: Parameters = ["mobileNumber": phoneNumber!, "tempPass" : tempPass!]
            let verifyUrl = "https://mdev1.yoman.co.il/api/Client/verifyLogin"

        AlmofireService.getData(url: verifyUrl, method: .post, parameters: parameters, headers: ["TaTtkn" : loginTkn!]) {responseObject, error in
            let TaTtkn =  self.parseToken(json: responseObject!)

            defaults.set(TaTtkn, forKey: "TaTtkn")
            semaphore.wait();
            }
            semaphore.signal();
            if(TaTtkn != nil){
                DispatchQueue.main.async{
                    self.goToNextView()
                }
            }
    }
}
    func goToNextView() {
        performSegue(withIdentifier: "toAccounts", sender: self)
    }
    
    func parseToken(json : [String:Any]) -> String! {
        let thedata = json["data"]as? [String: Any]
        let loginTkn = thedata!["token"]as? String
        return loginTkn
    }
    
    func toggleProgress(show:Bool){
        show ? progressBar.startAnimating() : progressBar.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start verify**************************************")

        let loginTkn = defaults.string(forKey: "loginTkn")
    
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

