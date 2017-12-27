//
//  AccountsCollectionViewController.swift
//  yoman
//
//  Created by רותם שיין on 29/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

var TaTtkn = defaults.string(forKey: "TaTtkn")
var acount:Account!

class AccountsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var Accounts:[Account] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noneAccounts: UILabel!
    
    //define the progress bar
    @IBOutlet weak var ProgressBar: UIActivityIndicatorView!{
        didSet{
            ProgressBar.hidesWhenStopped = true
            ProgressBar.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            ProgressBar.color = UIColor(hexString: "#37474f")
        }
    }
    func toggleProgress(show:Bool){
        show ? ProgressBar.startAnimating() : ProgressBar.stopAnimating()
    }
    override func viewWillAppear(_ animated: Bool) {
        if (!internetConnection){
            goToWelcome()
        }
        UIApplication.shared.isStatusBarHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("account **********************")
        TaTtkn = defaults.string(forKey: "TaTtkn")
        toggleProgress(show: true)
        getTheAccounts()
    }
    
    func getTheAccounts(){
        accountsDataSource.getData(completion: { success,err in
            if(success != nil){
                self.Accounts = success!
                if(self.Accounts.isEmpty){
                    self.noneAccounts.isHidden = false
                }
            }else {
                self.displayMsg(title: "ניסיון התחברות לא התקין", msg: err! + " ,נסה/י שנית מאוחר יותר")
            }
            self.toggleProgress(show: false)
            print("this is the items!")
            self.collectionView?.reloadData()
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 16)  //some width
        let height = (width/5 )+5 //ratio
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //configure the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcountCell", for: indexPath)as! AccCollectionViewCell
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: cell.layer.bounds.minX, y:cell.layer.bounds.maxY ))
        shadowPath.addLine(to: CGPoint(x: cell.layer.bounds.maxX, y: cell.layer.bounds.maxY ))
        shadowPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shadowPath.cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 2
        
        cell.layer.addSublayer(shapeLayer)
        
        // Configure the cell
        let item = Accounts[indexPath.item]
        cell.titleLabel.text = item.title
        cell.numFutureEvent.text = String(item.futureEvents)
        
        return cell
    }
    // on click account
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        acount = Accounts[indexPath.item]
        performSegue(withIdentifier: "toWebView" , sender: acount)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
