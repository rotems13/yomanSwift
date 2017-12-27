//
//  verifyTableViewController.swift
//  yoman
//
//  Created by רותם שיין on 27/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire

var phoneNumber = defaults.string(forKey: "phoneNumber")
var loginTkn = defaults.string(forKey: "loginTkn")

class verifyTableViewController: UITableViewController, UITextFieldDelegate {
    let limitLength = 4
    var totalTime = 31
    
    @IBOutlet weak var t4: UITextField!
    @IBOutlet weak var t3: UITextField!
    @IBOutlet weak var t2: UITextField!
    @IBOutlet weak var t1: UITextField!
    
    // no status bar
    override var prefersStatusBarHidden: Bool {return true}
  
    //define the progress bar
    @IBOutlet weak var progressBar: UIActivityIndicatorView!{
        didSet{
            progressBar.hidesWhenStopped = true
            progressBar.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            progressBar.color = UIColor(hexString: "#37474f")
        }
    }
    
    //text field 1 will be first
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        t1.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start Verify***************")
//        self.targetUITextFIeld()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        loginTkn = defaults.string(forKey: "loginTkn")
    }
    
    //go from one box to another
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let when = DispatchTime.now() + 0.08
        let oldText = textField.text!
//        let oldlength = oldText.count
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        let newlength = newText.count
        let tag = textField.tag
       
        if (newlength == 0 )  {
            print("back")
            let next = self.view.viewWithTag(tag - 1)
            DispatchQueue.main.asyncAfter(deadline: when) {
            next?.becomeFirstResponder()
            }
        }else if (newlength == 1){

            let next = self.view.viewWithTag(tag + 1)
            DispatchQueue.main.asyncAfter(deadline: when) {
//                if(tag == 4){
//                    self.submitVerifyNumber("")
//            }
                next?.becomeFirstResponder()
            }
        }
        return true
    }
    
    @IBAction func submitVerifyNumber(_ sender: Any) {
        if(internetAlert() && checkVerifyCode()){
            toggleProgress(show: true)
            let tempPass = t1.text! + t2.text! + t3.text! + t4.text!
            phoneNumber = defaults.string(forKey: "phoneNumber")
            let parameters: Parameters = ["mobileNumber": phoneNumber!, "tempPass" : tempPass]
            let verifyUrl = "https://mdev1.yoman.co.il/api/Client/verifyLogin"
            
            AlmofireService.getData(url: verifyUrl, method: .post, parameters: parameters, headers: ["TaTtkn" : loginTkn!], completionHandler: { success,err  in
                if (success != nil){
                    let TaTtkn =  self.parseToken(json: success!)
                    defaults.set(TaTtkn, forKey: "TaTtkn")
                    if(TaTtkn != nil){
                        self.goToNextView()
                    }
                }else {
                    self.displayMsg(title: "ניסיון התחברות לא התקין", msg: err! + " ,נסה/י שנית מאוחר יותר")
                    self.toggleProgress(show: false)
                }
            })
        }
    }
    //check cerify code
    func checkVerifyCode() -> Bool{
        let verifyCode = t1.text! + t2.text! + t3.text! + t4.text!
        print(verifyCode)
        if (verifyCode.count != 4 || (verifyCode.isEmpty)){
            displayMsg(title: "קוד אימות לא תקין", msg:" נסה/י שנית")
            toggleProgress(show: false)
            return false
        }
        else {return true}
    }
    //get the token from server
    func parseToken(json : [String:Any]) -> String! {
        let thedata = json["data"]as? [String: Any]
        let loginTkn = thedata!["token"]as? String
        return loginTkn
    }
    //control on progress bar
    func toggleProgress(show:Bool){
        show ? progressBar.startAnimating() : progressBar.stopAnimating()
    }
    //go to account
    func goToNextView() {
        self.toggleProgress(show: false)
        performSegue(withIdentifier: "toAccounts", sender: self)
    }
    
    //update the timer
    @IBOutlet weak var countdoen: UILabel!
    @IBAction func goBackToLogin(_ sender: Any) {
        if (totalTime == 0){
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "loginVc") as! loginViewController
            self.present(viewController, animated: false, completion: nil)
            
        }
    }
    @objc func update() {
        if(totalTime > 0) {
            totalTime = totalTime - 1
            countdoen.text = String(totalTime)
        }
    }
}
