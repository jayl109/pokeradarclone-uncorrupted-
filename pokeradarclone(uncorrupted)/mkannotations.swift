//
//  mkannotations.swift
//  map
//
//  Created by Jason Lum on 7/19/16.
//  Copyright © 2016 Jason Lum. All rights reserved.
//
import MapKit

import Foundation

class mkannotations: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?
    
    init(title: String, coordinate: CLLocationCoordinate2D, image: UIImage?) {
        if image != nil{
            self.image=image!
        }
        self.title=title
        self.coordinate=coordinate
        super.init()
        
    }
    
    
}
/*
class mkannotations: MKAnnotationView {
    var title: String?
        
   
 
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
        super.init(annotation: annotation, reuseIdentifier:reuseIdentifier)
        self.image=UIImage(named: "Lapras")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
 
    
}*/