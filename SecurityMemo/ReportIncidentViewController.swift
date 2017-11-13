//
//  ReportIncidentViewController.swift
//  SecurityMemo
//
//  Created by Frank on 11/12/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit

class ReportIncidentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var useCurLocationSwitch: UISwitch!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func useCurLocationSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            locationTextField.isHidden = true // hide location input field
            
            // get the current location with coordinates and name
            
        }
        else {
            locationTextField.isHidden = false //show location input field for user interaction
        }
        
    }
  
    
    // get the time of the date time picker
    @IBAction func dateTimePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }

    @IBAction func cameraBtnPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func photoLibraryBtnPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up border for description textView and imageView
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        
        // default the use current location switch on, and hide location input field 
        useCurLocationSwitch.isOn = true
        locationTextField.isHidden = true

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
