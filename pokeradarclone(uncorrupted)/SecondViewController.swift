//
//  SecondViewController.swift
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

class SecondViewController: UIViewController, UITextFieldDelegate{

    //var date=NSDate()
    var database=FIRDatabaseReference.init()
    var locationregion:MKCoordinateRegion?=nil
    @IBOutlet weak var pokemonname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor(red: 0, green: 191.0, blue: 255.0, alpha: 1.0)
        database = FIRDatabase.database().reference()
        pokemonname.delegate=self
        if locationregion != nil{
            print(locationregion!.center.latitude)
                    }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func submitPokemon(sender: AnyObject) {
        print ("Your pokemon is:")
        if pokemonname.text != nil && pokemonname.text != "" && locationregion != nil
        {
            let key = database.childByAutoId().key
            let stuff = ["Name": String(pokemonname.text!), "Lat": Double(locationregion!.center.latitude), "Long": Double(locationregion!.center.longitude)]
            self.database.child(key).setValue(stuff)
               }
        else{
            print ("no pokemon entered")
        
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }

}
