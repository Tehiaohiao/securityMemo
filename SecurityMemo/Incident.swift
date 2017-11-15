//
//  Incident.swift
//  SecurityMemo
//
//  Created by Frank on 11/13/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit
class Incident {
    
    enum IncidentType {
        case Robbery
        case Theft
        case Violent
        case Burglary
        case Others
    }
    
    public static let MISS_SUMMARY = "summary"
    public static let MISS_LOCATION = "location"
    public static let MISS_DATETIME = "datetime"
    public static let MISS_DESCRIPTION = "description"
    public static let MISS_PICTURE  = "picture"
    
    var summary: String? = ""
    var type: IncidentType? = .Others
    var location: Location? = Location()
    var dateTime: DateComponents? = nil
    var description: String? = nil
    var picture: UIImage? = nil
    

    
    // check if all propertities are presented
    public func check() -> (Bool, String) {
        if summary == "" {
            print("summary")
            return (false, Incident.MISS_SUMMARY)
        }
        if location == nil || location?.name == nil || location?.coordinate == nil ||
            location?.coordinate?.longitude ==  nil || location?.coordinate?.latitude == nil {
            print("location")
            return (false, Incident.MISS_LOCATION)
        }
        
        if dateTime == nil || dateTime?.year == nil || dateTime?.month == nil || dateTime?.day == nil ||
            dateTime?.hour == nil || dateTime?.minute == nil {
            print("time")
            return (false, Incident.MISS_DATETIME)
        }
        if description == nil || description == "" {
            print("description")
            return (false, Incident.MISS_DESCRIPTION)
        }
        if picture  == nil {
            print("picture")
            return (false, Incident.MISS_PICTURE)
        }
        
        return (true, "")
    }
    
    
}
