//
//  SKGoogleShowViewController.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 30/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import GoogleMaps
import Floaty
class SKGoogleShowViewController: UIViewController {

    @IBOutlet var googleMap: GMSMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        self.googleMap.camera = camera;
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 31.5115690000000, longitude: 74.328154)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = self.googleMap

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.title = "Near by"
        let floaty = Floaty()
        floaty.buttonImage = UIImage.init(named: "coloredfemale")
        floaty.addItem("doctor", icon: UIImage(named: "Phone")!, handler: { item in
//            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: {
//
//            })
             self.callGoogleAPIWithString(parmString: "doctor")
            floaty.close()
        })

        floaty.addItem("doctor2", icon: UIImage(named: "Phone")!, handler: { item in
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            //            self.present(alert, animated: true, completion: {
            //
            //            })
            self.callGoogleAPIWithString(parmString: "doctor")
            floaty.close()
        })
        self.view.insertSubview(self.googleMap, at: 0)
        self.view.insertSubview(floaty, at: 1)
    }
    //


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func callGoogleAPIWithString(parmString : String) -> Void {

//        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(String(describing: self.googleMap.myLocation?.coordinate.latitude)),\(String(describing: self.googleMap.myLocation?.coordinate.longitude))&radius=5000&keyword=\(parmString)&key=\(APIKey.KGoogleAPIKey)"

        APIManager.GET(url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=31.5204,74.3587&radius=5000&keyword=dotors&key=AIzaSyAN0icHW5F4iWKk8evPSmaO7jIDDf8vxcI"  , parameters: [:]) { (response, json) in
            debugPrint(json?.stringValue);
            if let jsonDict = json?.dictionaryObject {
                if  let status = jsonDict["status"] as? String{
                    if(status == "OK"){
                        let results = (jsonDict["results"] as? Array) ?? []
                        if results.count > 0 {
                            for data in results {
                            if let objectvalue = (data as? Dictionary<String, AnyObject>) {
                                    if  let geometry = (objectvalue["geometry"] as? Dictionary<String, AnyObject>)  {
                                        if  let location = (geometry["location"] as? Dictionary<String, AnyObject>) {
                                            let marker = GMSMarker()
                                            marker.position = CLLocationCoordinate2D(latitude:location["lat"] as! CLLocationDegrees, longitude: location["lng"] as! CLLocationDegrees)
                                            marker.map = self.googleMap
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
extension SKGoogleShowViewController: CLLocationManagerDelegate {
    // 2
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .authorizedWhenInUse {

            // 4
            locationManager.startUpdatingLocation()

            //5
            self.googleMap.isMyLocationEnabled = true
            self.googleMap.settings.myLocationButton = true
        }
    }

    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {

            // 7
            self.googleMap.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            // 8
            locationManager.stopUpdatingLocation()

             self.callGoogleAPIWithString(parmString: "dotors")
        }

    }
}
