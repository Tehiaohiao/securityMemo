//
//  IncidentDetailViewController.swift
//  SecurityMemo
//
//  Created by Frank on 11/16/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit

class IncidentDetailViewController: UIViewController {
    
    var incident: Incident!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailedInfoTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.incident.picture
        self.detailedInfoTextView.text = self.prepareDetailInfo()
    }

    private func prepareDetailInfo() -> String {
        return "Location:  \n" +
                "   \(self.incident.location!.name!) \n" +
                "Summay: \n" +
                "   \(self.incident.summary!) \n" +
                "Type: \(self.incident.type!.rawValue) \n" +
                "Time: \(Utilities.dateCompToString(date: self.incident.dateTime)) \n" +
                "Description: \(self.incident.description!)"
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
