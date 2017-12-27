//
//  ContactUSViewController.swift
//  yoman
//
//  Created by רותם שיין on 14/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import Alamofire
class ContactUSViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let requestTypeUrl:String  = "https://mdev1.yoman.co.il/api/Client/GetContactUsRequestTypes"
    let contactUsUrl :String = "https://mdev1.yoman.co.il/api/Client/ContactUs"
    var result = [String]()

    @IBOutlet weak var progressbar: UIActivityIndicatorView!{
        didSet{
            progressbar.hidesWhenStopped = true
            progressbar.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            progressbar.color = UIColor(hexString: "#37474f")
        }
    }
    @IBOutlet weak var username: contactTxtField!
    @IBOutlet weak var userPhone: contactTxtField!
    @IBOutlet weak var picerTextField: contactTxtField!
    @IBOutlet weak var userContent: UITextView!{
        didSet{
            let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
            userContent.layer.borderWidth = 0.5
            userContent.layer.borderColor = borderColor.cgColor
            userContent.layer.cornerRadius = 5.0
        }
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false)
    }
    
    @IBAction func userSubmit(_ sender: Any) {
        if(!internetAlert() && validateForm()){
            dismiss(animated: false)
        }
        let parameters: Parameters = ["content": userContent.text!, "requestType": picerTextField.text!, "name": username.text!,"phone": userPhone.text!]
        AlmofireService.getData(url: contactUsUrl, method: .post, parameters: parameters, headers: nil, completionHandler: { success,err  in
            if (success != nil){
                self.displayMsg(title: "ההודעה נשלחה בהצלחה", msg:"")
                
                self.toggleProgress(show: false)
                self.dismiss(animated: false)
            }else{
                self.displayMsg(title: "ניסיון התחברות לא התקין", msg: err! + " ,נסה/י שנית מאוחר יותר")
                self.toggleProgress(show: false)
            }
            })
    }
    func toggleProgress(show:Bool){
        show ? progressbar.startAnimating() : progressbar.stopAnimating()
    }
    
    func validateForm()->Bool{
        
        return true
    }
    //full screen - hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //set user name text field tu first responder
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    // call the subject titles and fill the picker subject
    override func viewDidLoad() {
        super.viewDidLoad()
        getItemsForPickerView()
    }
    
    func getItemsForPickerView(){
        AlmofireService.getData(url: requestTypeUrl, method: .get, parameters: nil, headers: nil, completionHandler: { success,err  in
            if (success != nil){
                self.result = self.parseItems(json: success!) as! [String]
                self.setPicker()
            }else {
                self.displayMsg(title: "התרחשה שגיאה", msg: err! + " ,נסה/י שנית מאוחר יותר")
            }
        })
    }
    func parseItems(json : [String:Any]) -> [String?] {
        let thedata = json["data"]as? [String]
        return thedata!
    }
    func setPicker(){
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor(hexString: "#37474F")
        self.picerTextField.inputView = pickerView
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        picerTextField.text = result[row]
        self.view.viewWithTag(4)!.becomeFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return result[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return result.count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = result[row]
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//move between the next fields
extension ContactUSViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("")
        let tag = textField.tag
        let next = self.view.viewWithTag(tag + 1)
        next?.becomeFirstResponder()
        return true
    }
    
}



