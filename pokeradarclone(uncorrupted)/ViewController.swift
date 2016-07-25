//
//  ViewController.swift
//  map
//
//  Created by Jason Lum on 7/18/16.
//  Copyright © 2016 Jason Lum. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var map=CLLocationManager()
    var locationStatus = "Not started"
    var timer=NSTimer()
    var database = FIRDatabaseReference.init()
    var defaultspan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    var locationregion:MKCoordinateRegion?=nil
    
    
    @IBOutlet weak var mapkit: MKMapView!
    
    /* OLD CODE USED FOR DEBUGGING
    @IBAction func add(sender: UIButton) {
        //self.database.child("One").child("Name").setValue("success")
        let key = database.childByAutoId().key
        let stuff = ["Lat": Double(latitude.text!)!, "Long": Double(longitude.text!)!]
        self.database.child(key).setValue(stuff)
        
    }
 */
    
    
    //returns map to your location
    @IBAction func resetlocation(sender: AnyObject) {
        if locationregion != nil{
           mapkit.region=locationregion!
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = FIRDatabase.database().reference()
        mapkit.delegate=self
        map.delegate = self
        map.desiredAccuracy = kCLLocationAccuracyBest
        map.distanceFilter = kCLDistanceFilterNone
        map.startUpdatingLocation()
        map.requestAlwaysAuthorization()
        
        
        //let tokyo = CLLocationCoordinate2D(latitude: 35.698, longitude: 139.75)
        
        //let annotation=mkannotations(title: "Lapras", coordinate: tokyo, image: UIImage(named:"Lapras"))
       // mapkit.addAnnotation(annotation)
        //MARK: Database code
        database.observeEventType(.ChildAdded, withBlock: { snapshot in
            let postDict = snapshot.value as! [String : AnyObject]
            let annotation=mkannotations(title: (postDict["Name"] as! String), coordinate: CLLocationCoordinate2D(latitude: (postDict["Lat"]! as! Double), longitude: (postDict["Long"]!) as! Double), image: UIImage(named:"Lapras"))
            self.mapkit.addAnnotation(annotation)
            print (snapshot.value)
            //print (postDict["Lat"]!)
            //print (postDict["Long"]!)
            }
        )
 
       
     
    }

    
    

    
    
    
    
    //MARK: locationmanager code
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]){
        
        locationregion = MKCoordinateRegion(center: locations[0].coordinate, span: defaultspan)
        
        
        
    }
    func locationManager(manager: CLLocationManager,
                                  didChangeAuthorizationStatus status: CLAuthorizationStatus){
        
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            map.startUpdatingLocation()
            
                       
        }
        
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "pokemon"
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.image=UIImage(named: "Lapras")
        
            return view
            }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let nav = segue.destinationViewController as! SecondViewController
            nav.locationregion = locationregion
        
    }
}



