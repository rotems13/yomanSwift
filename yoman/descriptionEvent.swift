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

    @IBOutlet weak var descriptionTitle: UILabel!{
        didSet{
            descriptionTitle.text = acount.title
        }
    }
    
    @IBOutlet weak var descriptionLine: UIView!{
        didSet{
            let shadowPath = UIBezierPath()
            shadowPath.move(to: CGPoint(x: descriptionLine.layer.bounds.origin.x, y: descriptionLine.layer.frame.size.height))
            shadowPath.addLine(to: CGPoint(x: descriptionLine.layer.bounds.width / 2, y: descriptionLine.layer.bounds.height + 7.0))
            shadowPath.addLine(to: CGPoint(x: descriptionLine.layer.bounds.width, y: descriptionLine.layer.bounds.height))
            shadowPath.close()
            descriptionLine.layer.shadowColor      = UIColor.black.cgColor
            descriptionLine.layer.shadowOffset     = CGSize(width: 0, height: 1)
            descriptionLine.layer.shadowRadius     = 4
            descriptionLine.layer.shadowOpacity    = 0.2
            descriptionLine.layer.zPosition        = 25
            descriptionLine.layer.shadowPath       = shadowPath.cgPath
            descriptionLine.layer.masksToBounds    = false
        }
    }
    @IBOutlet weak var googleMap: UIView!
    
//    {
//        didSet{
//            // Create a GMSCameraPosition that tells the map to display the
//            // coordinate -33.86,151.20 at zoom level 6.
//            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//            mapView.delegate = self as? GMSMapViewDelegate
//            mapView.camera = camera
//            self.googleMap = mapView
        
//            // Creates a marker in the center of the map.
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//            marker.title = "Sydney"
//            marker.snippet = "Australia"
//            marker.map = mapView
            
//        }
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

       
//         mapView.camera = camera

        
       
//        mapView.animate(toViewingAngle: 45)

        
        // Do any additional setup after loading the view.
        // Creates a marker in the center of the map.
        
        
        geoCode(address: "המלאכה 28, נתניה")
    }
    
    func geoCode(address: String!) {
//        let address = "1 Infinite Loop, Cupertino, CA 95014"
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("problam")
                    // handle no location found
                    return
            }
            print("cordinate")
            self.reloadMap(location: location)
            print(location.coordinate)

            
            // Use your location
        }

    }
    func reloadMap(location: CLLocation) {
         mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: self.googleMap!.bounds.height + 20), camera: GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 1.0))
        self.googleMap.addSubview(mapView)
        self.mapView.animate(toZoom: 14)
        
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
