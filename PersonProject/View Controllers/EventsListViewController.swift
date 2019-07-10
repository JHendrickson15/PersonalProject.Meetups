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
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventsToDetailVC" {
            if let index = eventsTableView.indexPathForSelectedRow?.row {
                let destinationVC = segue.destination as? EventsCreationViewController
                
                let locations = location[index]
                destinationVC?.location = locations
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


    

