
//
//  IncidentPinAnnotation.swift
//  SecurityMemo
//
//  Created by Frank on 11/15/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//
import UIKit
import MapKit
class IncidentPinAnnotation: MKPointAnnotation {
    var incident: Incident!

    init(incident: Incident) {
        super.init()
        if !incident.check().0 {
            print("CANNOT GET ANNOTATION FOR AN INVALID INCIDENT")
            return
        }
        self.incident = incident
        self.coordinate = (self.incident.location?.coordinate!)!
        self.title = self.incident.location?.name!
    }
    
    // get the name of image for the pin from the incident type
    public func getPinImageName() -> String{
        switch self.incident.type! {
        case Incident.IncidentType.Robbery:
            return "robberyPin"
        case Incident.IncidentType.Theft:
            return "theftPin"
        case Incident.IncidentType.Violent:
            return "violentPin"
        case Incident.IncidentType.Burglary:
            return "burglaryPin"
        case Incident.IncidentType.Others:
            return "othersPin"
        default:
            return "multiplePin"
        }
    }
    
    // get a key for the annotation
    public func getKey() ->String? {
        return Utilities.convertCoordinateToKey(coord: self.coordinate)
    }
    
    
    
    
}
