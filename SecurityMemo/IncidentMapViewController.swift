//
//  IncidentMapViewController.swift
//  SecurityMemo
//
//  Created by Frank on 11/15/17.
//  Copyright © 2017 SecurityMemoTeam. All rights reserved.
//

import UIKit
import MapKit


class IncidentMapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    private let SPAN_WIDTH: CLLocationDegrees = 0.05    // default span with when you search a place
    private let PIN_SIZE: CGFloat = 50          // default size of pin annotation
    private let INCIDENT_PIN_IDENTIFIER = "IncidentPinIdentifier"   //default annotation veiw indentifier
    private var locationManager: LocationManager!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure activity indicator
        self.activityIndicator.hidesWhenStopped = true
        
        // initialize location manager, which manges all about loction stuffs
        self.locationManager = LocationManager()
        
        // configure map view
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true // show user's location
        // zoom in to current location
        if let coord = self.locationManager.getCurCoordinate()?.coordinate {
            let region = MKCoordinateRegionMake(coord, MKCoordinateSpanMake(self.SPAN_WIDTH, self.SPAN_WIDTH))
            self.mapView.setRegion(region, animated: true)
        }
        
        // add annotation for each incident
        // NOTE: using mock database for now
        for ict in MockDatabase.database {
            self.mapView.addAnnotation(IncidentPinAnnotation(incident: ict))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.mapView != nil {
            self.mapView.removeAnnotations(self.mapView.annotations)
            // add annotation for each incident
            // NOTE: using mock database for now
            for ict in MockDatabase.database {
                self.mapView.addAnnotation(IncidentPinAnnotation(incident: ict))
            }
        }
        
    }

    
    @IBAction func searchBtnPressed(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    
    // search text done inputing by users
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // start activity indicator
        self.activityIndicator.startAnimating()

        // hide search bar 
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        // do the searching on seperate thread
        DispatchQueue.global(qos: .userInitiated).async {
            self.searchLocation(searchText: searchBar.text)
            DispatchQueue.main.async {
                // stop activity indicator
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    // helper function to search a location based on user input text and update the map view
    private func searchLocation(searchText: String!) {
        let searchRequest: MKLocalSearchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchText
        let searchResult = MKLocalSearch(request: searchRequest)
        searchResult.start { (response, error) in
            if error != nil {
                print("CANNOT SEARCH FOR THE GIVEN REQUEST")
                return
            }
            let span = MKCoordinateSpanMake(self.SPAN_WIDTH, self.SPAN_WIDTH)
            let region = MKCoordinateRegionMake((response?.boundingRegion.center)!, span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    // customize annotation view for each annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: self.INCIDENT_PIN_IDENTIFIER)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: self.INCIDENT_PIN_IDENTIFIER)
            annotationView?.canShowCallout = true // enable call out
        }
        else {
            annotationView?.annotation = annotation
        }
        
        // customize pin image
        if annotation is IncidentPinAnnotation {
            let ictPinAnnotation = annotation as! IncidentPinAnnotation
            if let image = UIImage(named: ictPinAnnotation.getPinImageName()) {
                annotationView?.image = Utilities.resizeImage(image: image, newWidth: self.PIN_SIZE)
                let btn = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = btn
            }
        }
        
        return annotationView
    }
    
    // segue to detailed view
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control ==  view.rightCalloutAccessoryView && view.annotation is IncidentPinAnnotation {
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "incidentDetailVC") as! IncidentDetailViewController
            let inctAnnotation = view.annotation as! IncidentPinAnnotation
            detailVC.incident = inctAnnotation.incident
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
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
