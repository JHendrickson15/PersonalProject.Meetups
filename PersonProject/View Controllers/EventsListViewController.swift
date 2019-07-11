//
//  EventsListViewController.swift
//  PersonProject
//
//  Created by Jordan Hendrickson on 7/9/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EventsListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    var searchByLocation: Bool = true
    
    
    
    
    var location: [Events] = [] {
        didSet{
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 everything starts out hidden
        eventsTableView.isHidden = true
        searchBar.isHidden = true
        navigationController?.setToolbarHidden(true, animated: false)
        userNameTextField.isHidden = true
        passwordTextField.isHidden = true
        signupButton.isHidden = true
        // hide the tab bar also
        
        // 2 fetch the user if there is one
        UserController.shared.fetchCurrentUser { (success) in
            if success {
                DispatchQueue.main.async {
                    self.eventsTableView.isHidden = false
                    self.searchBar.isHidden = false
                    self.userNameTextField.isHidden = true
                    self.passwordTextField.isHidden = true
                    self.signupButton.isHidden = true
                }
            }else{
                DispatchQueue.main.async {
                    self.eventsTableView.isHidden = true
                    self.searchBar.isHidden = true
                    self.userNameTextField.isHidden = false
                    self.passwordTextField.isHidden = false
                    self.signupButton.isHidden = false
                }
            }
        }
        self.searchByLocation = false
        EventsController.shared.fetchEvents(searchTerm: "postalCode") { (locations) in
            EventsController.shared.events = locations ?? []
            self.location = locations ?? []
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
        //core location request
        locationManager = CLLocationManager()
        locationManager?.delegate = self as? CLLocationManagerDelegate
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == CLAuthorizationStatus.notDetermined{
            locationManager?.requestWhenInUseAuthorization()
            print("No permissions here😳😳😳😳")
        }else{
            print("we got them permissions🤗🤗🤗🤗")
            //            mapView.showsUserLocation = true
            if locationManager?.location == nil{
                locationManager?.startUpdatingLocation()
            }
            self.location = EventsController.shared.events
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventsToDetailVC" {
            if let index = eventsTableView.indexPathForSelectedRow?.row {
                let destinationVC = segue.destination as? EventsCreationViewController
                
                let locations = location[index]
                destinationVC?.location = locations
            }
        }
    }
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        guard let username = userNameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
            else {return}
        
        UserController.shared.createNewUser(username: username, password: password) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.eventsTableView.isHidden = false
                    self.searchBar.isHidden = false
                    self.userNameTextField.isHidden = true
                    self.passwordTextField.isHidden = true
                    self.signupButton.isHidden = true
                    
                    return
                }
            }
        }
    }
}
extension EventsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventsController.shared.events.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? EventsListTableViewCell
        
        let selectedEvent = EventsController.shared.events[indexPath.row]
        
        cell?.EventsResults = selectedEvent
        print("labelhasbeenchanged")
        
        return cell ?? UITableViewCell()
    }
}
extension EventsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        EventsController.shared.fetchEvents(searchTerm: searchTerm) { (events) in
            EventsController.shared.events = events ?? []
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
}




