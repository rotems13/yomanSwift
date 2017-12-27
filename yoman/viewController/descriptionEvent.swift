//
//  descriptionEvent.swift
//  yoman
//
//  Created by רותם שיין on 11/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import GoogleMaps
//AIzaSyC3DWMJLZPvRp36Wnxb0-AhxU3xq1kDau4


class descriptionEvent: UIViewController {
    var mapView:GMSMapView!
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var descriptionDescription: UILabel!
    @IBOutlet weak var AdressDescription: UILabel!
    @IBOutlet weak var siteDescription: UILabel!
    @IBOutlet weak var phoneDescription: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!{
    didSet{descriptionTitle.text = acount.title}
    }
    @IBOutlet weak var descriptionLine: UIView!{
        didSet{createShadow(view: descriptionLine)}
    }
    @IBAction func backToAccount(_ sender: Any) {
        dismiss(animated: false)
    }
    @IBAction func goToFutureEvents(_ sender: Any) {
        goToFutureEvent()
    }
    @IBAction func goToWebView(_ sender: Any) {
        goToWebView()
    }
    
    @IBOutlet weak var googleMap: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        if (!internetConnection){
            goToWelcome()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleDescription.text = acount.title
        descriptionDescription.text = ";kjbvksdjfbsadkgjbs;kkn;kn;jndflkkjbvksdjfbsadkgjbs;kkn;kn;jndflkkjbvksdjfbsadkgjbs;kkn;kn;jndflkkjbvksdjfbsadkgjbs;kkn;kn;jndflkkjbvksdjfbsadkgjrרותםםםםםםםםםםbsjndflkkjbvksdjfbsadkgjrרותםjbs;kkn;kn;jndflkkjbvksdjfbsadkgjbs;kkn;kn;jndflk;hj"
        //acount.description
        AdressDescription.text = "המלאכה 28, נתניה"//acount.contactAdress
        phoneDescription.text = acount.contactNumber
        siteDescription.text = acount.siteURL
        
        geoCode(address: "המלאכה 28, נתניה")
    }
    
    func geoCode(address: String!) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("problam")
                    return
            }
            print("cordinate")
            self.reloadMap(location: location)
            print(location.coordinate)
        }
    }
    
    func reloadMap(location: CLLocation) {
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: self.googleMap!.bounds.height), camera: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 14.0))
        mapView.settings.compassButton = true
        googleMap.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.title = "TagATime"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

