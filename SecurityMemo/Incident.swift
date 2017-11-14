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
    
    
    var summary: String? = ""
    var type: IncidentType? = .Others
    var location: Location? = Location()
    var dateTime: DateComponents? = nil
    var description: String? = nil
    var picture: UIImage? = nil
    

    
    // check if all propertities are presented
    public func check() -> Bool {
        if summary == "" {
            return false
        }
        if location == nil || location?.name == nil || location?.coordinate == nil ||
            location?.coordinate?.longitude ==  nil || location?.coordinate?.latitude == nil {
            return false
        }
        
        if dateTime == nil || dateTime?.year == nil || dateTime?.month == nil || dateTime?.day == nil ||
            dateTime?.hour == nil || dateTime?.minute == nil {
            return false
        }
        if description == nil || picture == nil {
            print("image and description")
            return false
        }
        
        return true
    }
    
    
}
