
//
//  IncidentPinAnnotation.swift
//  SecurityMemo
//
//  Created by Frank on 11/15/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//
import UIKit
import MapKit

// customized annotation
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
        self.subtitle = self.getSubTitle()
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
    
    // get a key for the annotation to match the annotation with an incident stored in database
    public func getKey() ->String? {
        return Utilities.convertCoordinateToKey(coord: self.coordinate)
    }
    
    
    // get displaying text for subtitle
    public func getSubTitle() -> String? {
        var numRob = 0
        var numThef = 0
        var numViol = 0
        var numBurg = 0
        var numOthers = 0
        
        // case of only one report for the location
        switch self.incident.type! {
        case Incident.IncidentType.Robbery:
            numRob += 1
            break
        case Incident.IncidentType.Theft:
            numThef += 1
            break
        case Incident.IncidentType.Violent:
            numViol += 1
            break
        case Incident.IncidentType.Burglary:
            numBurg += 1
            break
        case Incident.IncidentType.Others:
            numOthers += 1
            break
        default:
            break
        }
        
        return "R(\(numRob)), T(\(numThef)), V(\(numViol)), B(\(numBurg)), O(\(numOthers))"
    }
    
    
}
