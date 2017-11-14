//
//  ReportIncidentViewController.swift
//  SecurityMemo
//
//  Created by Frank on 11/12/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit

class ReportIncidentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var incident: Incident!
    @IBOutlet weak var locationTextField: UITextField!      // location text field
    @IBOutlet weak var descriptionTextView: UITextView!     // incident description
    @IBOutlet weak var useCurLocationSwitch: UISwitch!      // current location switch
    @IBOutlet weak var imageView: UIImageView!              // incident imageview
    @IBOutlet weak var dateTimePickerView: UIDatePicker!    // date and time picker view
    
    
    
    /*
     Initial configuration when view upload
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up border for description textView and imageView
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        
        // default the use current location switch on, and show the location
        useCurLocationSwitch.isOn = true
        disableLocationInput(curLocation: "Showing your current location")
        
        // default incident date has to be within 7 days and not in the future
        dateTimePickerView.minimumDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        dateTimePickerView.maximumDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        
        // initialize an incident
        self.incident = Incident()
        self.incident.dateTime = Calendar.current.dateComponents([.hour, .minute, .day, .month,.year], from: dateTimePickerView.date)
    }
    
    
    @IBAction func doneBtnPressed(_ sender: UIBarButtonItem) {
        self.incident.description = descriptionTextView.text
        
        // ------> working on
        print(self.incident.check())
    }
    
    // summary text field
    @IBAction func summaryChanged(_ sender: UITextField) {
        self.incident.summary = sender.text
    }
    
    // type segment
    @IBAction func typeSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.incident.type = Incident.IncidentType.Robbery
            case 1:
                self.incident.type = Incident.IncidentType.Theft
            case 2:
                self.incident.type = Incident.IncidentType.Violent
            case 3:
                self.incident.type = Incident.IncidentType.Burglary
            default:
                self.incident.type = Incident.IncidentType.Others
            
        }
    }
    
    // location input changed by user input
    
    @IBAction func locationChanged(_ sender: UITextField) {
        // location can only be editted by users when useCurLocationSwitch is off
        if !useCurLocationSwitch.isOn {
            self.incident.location?.name = sender.text!;
            
            
            // --------------> set up coordinates
            self.incident.location?.coordinate = Coordinate(longitude: "faked", latitude: "faked")
        }
    }
    
    // date and time picker
    @IBAction func datetimePickerChanged(_ sender: UIDatePicker) {
        self.incident.dateTime = Calendar.current.dateComponents([.hour, .minute, .day, .month,.year], from: sender.date)
    }

    
    // switch for user current loction utility
    @IBAction func useCurLocationSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            disableLocationInput(curLocation: "Showing your current location")  //disable user input for location
            
            // ---------> get the current location with coordinates and name
            
        }
        else {
            activateLoactionInput() // enable user input for loaction
        }
    }
  
    // camera btn interation
    @IBAction func cameraBtnPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    // photo libray interaction
    @IBAction func photoLibraryBtnPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            self.incident.picture = imageView.image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    // Helper function disables location input field to make it showing current location
    private func disableLocationInput(curLocation: String!) {
        locationTextField.text = curLocation
        locationTextField.isUserInteractionEnabled = false
    }
    
    // Helper function enables location input from user
    private func activateLoactionInput() {
        locationTextField.text = ""
        locationTextField.isUserInteractionEnabled = true
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
