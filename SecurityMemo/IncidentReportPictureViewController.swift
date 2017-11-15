//
//  IncidentPictureViewController.swift
//  SecurityMemo
//
//  Created by Frank on 11/14/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit

class IncidentReportPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var incident: Incident!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
        imageView.image = self.incident.picture
    }
    
    
    @IBAction func doneBtnPressed(_ sender: UIBarButtonItem) {
        let (integrated, missing) = self.incident.check()
        if integrated {
            // upload to database
            MockDatabase.database.append(self.incident)
            
            // go to map view
            tabBarController?.selectedIndex = 0
            return
        }
        if !integrated && missing == Incident.MISS_PICTURE {
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.red]
        }
        else {
            print("Unexpected part missing for incident: \(missing)")
        }
    }


    @IBAction func camBtnPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func photoLibBtnPressed(_ sender: UIButton) {
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

}
