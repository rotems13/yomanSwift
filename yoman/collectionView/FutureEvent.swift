//
//  FutureEvent.swift
//  yoman
//
//  Created by רותם שיין on 04/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

var event:futureEvent!


class FutureEvent: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var noneFutureEvent: UILabel!
    var events:[futureEvent] = []
    var categoryes:[Int : [futureEvent]] = [:]
    
    @IBAction func backToAccount(_ sender: Any) {
    dismiss(animated: false)
    }
    @IBAction func goToWebView(_ sender: Any) {goToWebView()}
    
    //the header view
    @IBOutlet weak var underFuture: UIView!{ didSet{createShadow(view: underFuture)}}
    @IBOutlet weak var futureTitle: UILabel!{ didSet{futureTitle.text = acount.title }}
    
    //start collection view
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ProgressBar: UIActivityIndicatorView!{
        didSet{
            ProgressBar.hidesWhenStopped = true
            ProgressBar.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            ProgressBar.color = UIColor(hexString: "#37474f")
        }
    }
    
    func toggleProgress(show:Bool){
        show ? ProgressBar.startAnimating() : ProgressBar.stopAnimating()}
    
    //internet check
    override func viewDidAppear(_ animated: Bool) {
        if (!internetConnection){
            goToWelcome()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start futureEvent**********************************")
        toggleProgress(show: true)
        getTheEvents()
    }
    
    func getTheEvents(){
        FutureDataSource.getData(completion: { success, err in
            if (success != nil) {
                self.events = success!
                if(self.events.isEmpty){
                    self.noneFutureEvent.isHidden = false
                }
                else{
                    self.categoryes = self.createSections(events: self.events)
                }
                
            }else   {
                self.displayMsg(title: "ניסיון התחברות לא התקין", msg: err! + " ,נסה/י שנית מאוחר יותר")
            }
            self.toggleProgress(show: false)
            self.collectionView.reloadData()
        })
    }
    
    func createSections(events: [futureEvent]) -> [Int: [futureEvent]]{
        var categorySectionNum:Int = 0
        var counter = 0
        var tempEventsWithSameDates: [futureEvent] = []
        for i in events {
            let date = i.date
            if ( counter > 0 ) {
                let lastDate = events[counter - 1].date
                if( date == lastDate){
                    tempEventsWithSameDates.append(i)
                    counter += 1
                    if(counter == events.count){
                        categoryes[categorySectionNum] = tempEventsWithSameDates
                    }
                    
                }else{ //dates not equal -> open new section and insert the event
                    categoryes[categorySectionNum] = tempEventsWithSameDates
                    tempEventsWithSameDates.removeAll()
                    categorySectionNum += 1
                    tempEventsWithSameDates.append(i)
                    counter += 1
                    if(counter == events.count){
                        categoryes[categorySectionNum] = tempEventsWithSameDates
                    }
                }
                
            }else { //the first event append to the first section
                tempEventsWithSameDates.append(i)
                counter += 1
            }
        }
        return categoryes
    }
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryes.keys.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryes[section]!.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 8)  //some width
        let height = (width/5 )+5 //ratio
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "futureCell", for: indexPath)as! FutureCell
        let theItem = categoryes[indexPath.section]
        
        
        
        // Configure the  cell
        let item = theItem![indexPath[1]]//events[indexPath.item]
        cell.resourceLabel.text = item.resource
        cell.resourceLabel.sizeToFit()
        
        cell.serviceLabel.text = item.services
        cell.statusLabel.text = item.status
        cell.startTimeLabel.text = item.startTime
        cell.startTimeLabel.textColor = UIColor(hexString: item.eColor)
        
        cell.lineStartTime.backgroundColor = UIColor(hexString: item.eColor)
        cell.eStatusColor.backgroundColor = UIColor(hexString: item.eStatusColor)
        cell.eStatusColor = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 64.0, height: 64.0)
        )
        return cell
    }
    
    //select event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        event = events[indexPath.item]
        print(event)
        performSegue(withIdentifier: "toEventWebView" , sender: event)
    }
    
    //section header view
    var count = 0
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeaderView", for: indexPath) as! sectionHeaderView
        
        let theCategory = categoryes[indexPath.section]
        let item = theCategory![indexPath[1]]
        let date = item.date
        sectionHeaderView.categoryDate = date
        
        return sectionHeaderView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
   
}
