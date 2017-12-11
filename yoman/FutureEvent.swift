//
//  FutureEvent.swift
//  yoman
//
//  Created by רותם שיין on 04/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

var event:futureEvent!


class FutureEvent: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "futureCell" 
    var events:[futureEvent] = []

    @IBOutlet weak var underFuture: UIView!{
        didSet{
            let shadowPath = UIBezierPath()
            shadowPath.move(to: CGPoint(x: underFuture.layer.bounds.origin.x, y: underFuture.layer.frame.size.height))
            shadowPath.addLine(to: CGPoint(x: underFuture.layer.bounds.width / 2, y: underFuture.layer.bounds.height + 7.0))
            shadowPath.addLine(to: CGPoint(x: underFuture.layer.bounds.width, y: underFuture.layer.bounds.height))
            shadowPath.close()
            underFuture.layer.shadowColor      = UIColor.black.cgColor
            underFuture.layer.shadowOffset     = CGSize(width: 0, height: 1)
            underFuture.layer.shadowRadius     = 4
            underFuture.layer.shadowOpacity    = 0.2
            underFuture.layer.zPosition        = 25
            underFuture.layer.shadowPath       = shadowPath.cgPath
            underFuture.layer.masksToBounds    = false
            
        }
    }
    @IBOutlet weak var futureTitle: UILabel!{
        didSet{
                futureTitle.text = acount.title
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ProgressBar: UIActivityIndicatorView!{
        didSet{
            ProgressBar.hidesWhenStopped = true
        }
    }
    
    func toggleProgress(show:Bool){
        show ? ProgressBar.startAnimating() : ProgressBar.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleProgress(show: true)
        print("Start futureEvent******************************************")
        FutureDataSource.getData(completion: { success in
            self.events = success
            print("this is the items!")
            print(self.events)
            self.toggleProgress(show: false)
            
            
            self.collectionView.reloadData()
        })
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "futureCell", for: indexPath)as! FutureCell
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: cell.layer.bounds.origin.x, y: cell.layer.frame.size.height))
        shadowPath.addLine(to: CGPoint(x: cell.layer.bounds.width / 2, y: cell.layer.bounds.height + 2.0))
        shadowPath.addLine(to: CGPoint(x: cell.layer.bounds.width, y: cell.layer.bounds.height))
        shadowPath.close()
        
        cell.layer.shadowColor      = UIColor.black.cgColor
        cell.layer.shadowOffset     = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius     = 4
        cell.layer.shadowOpacity    = 0.3
        cell.layer.zPosition        = 20
        cell.layer.shadowPath       = shadowPath.cgPath
        cell.layer.masksToBounds    = false
        // Configure the cell
        let item = events[indexPath.item]
        cell.resourceLabel.text = item.resource
        cell.serviceLabel.text = item.services
        cell.statusLabel.text = item.status
//        cell.startTimeLabel.text = item.startTime
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        event = events[indexPath.item]
        print("tapped")
        print(event)
        
        performSegue(withIdentifier: "toEventWebView" , sender: event)

    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let dest = segue.destination as? webViewController{
//            dest.url = sender! as! String    }
//    }
}


