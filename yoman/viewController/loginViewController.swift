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

class loginViewController: UITableViewController, UITextFieldDelegate  {
    let limitLength = 10
    
    //dismiss the side menu (exit)
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    @IBOutlet weak var edPhonenumber: UITextField!
    
    //go to contactForm
    @IBAction func goToContactUs(_ sender: Any) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "contactForm") as! ContactUSViewController
        
        self.present(viewController, animated: false, completion: nil)
    }
    // no status bar
    override var prefersStatusBarHidden: Bool {return true}
    //show keyboard every time view shown
    override func viewDidAppear(_ animated: Bool) {
        self.edPhonenumber.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edPhonenumber.delegate = self
    }
    //set maximum length to the text field - max 10
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= limitLength
    }
    //define the progres bar
    @IBOutlet weak var progressBar: UIActivityIndicatorView!{
        didSet{
            progressBar.hidesWhenStopped = true
            progressBar.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            progressBar.color = UIColor(hexString: "#37474f")
        }
    }
    //submit the phone number after validate to get login tkn
    @IBAction func SubmitNumber(_ sender: Any) {
        if(internetAlert() && checkPhoneNumber()){
            toggleProgress(show: true)
            let phoneNumber:String = edPhonenumber.text!
            defaults.set(phoneNumber, forKey: "phoneNumber")
            
            let parameters: Parameters = ["mobileNumber": phoneNumber]
            let loginURL = "https://mdev1.yoman.co.il/api/Client/Login"
            
            AlmofireService.getData(url: loginURL, method: .post, parameters: parameters, headers: nil, completionHandler: { success,err  in
                if (success != nil){
                    let logtkn = self.parseToken(json: success!)
                    defaults.set(logtkn, forKey: "loginTkn")
                    if(loginTkn != nil){
                        self.goToNextView()
                    }
                }else {
                    self.displayMsg(title: "ניסיון התחברות לא התקין", msg: err! + " ,נסה/י שנית מאוחר יותר")
                    self.toggleProgress(show: false)
                }
            })
        }
    }
    // define when open or close progress
    func toggleProgress(show:Bool){
        show ? progressBar.startAnimating() : progressBar.stopAnimating()
    }
    //checkPhone number
    func checkPhoneNumber() -> Bool{
        let phoneNum = edPhonenumber.text
        if (phoneNum?.count != 10 || (phoneNum?.isEmpty)!){
            displayMsg(title: "מספר טלפון לא תקין", msg:" נסה/י שנית")
            toggleProgress(show: false)
            return false
        }
        else {return true}
    }
    //get the login token
    func parseToken(json : [String:Any]) -> String! {
        let thedata = json["data"]as? [String: Any]
        let loginTkn = thedata!["token"]as? String
        return loginTkn
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //move to verify
    func goToNextView() {
        self.toggleProgress(show: false)
        self.edPhonenumber.text = ""
        performSegue(withIdentifier: "toVerify", sender: self)
    }
}

