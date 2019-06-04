//
//  ViewController.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()

    var presentor:ViewToPresenterProtocol?
    var cities:Array<City> = Array()

    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        // Initialize TableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        // Request Location Access Permission
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        // Get user location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
        // Fetch Initial Cities
        presentor?.startFetchingTokyo()
        presentor?.startFetchingLondon()
    }
    
    // Confirming aqcuisition of user location and fetching the relevant data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let loc: CLLocationCoordinate2D = location.coordinate
            presentor?.startFetchingCurrentCity(loc: loc)
        }
    }
    
    // CLLocationManager error handle
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    // Preparing selected city data for detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController,
            let index = tableView?.indexPathForSelectedRow?.row
            else {
                return
        }
        detailViewController.city = cities[index]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // TableView uses cities array for data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Prevents the table view from attempting to load rows from an empty data source
        return self.cities.count
    }
    // TableView cell setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let myCity = cities[indexPath.item]
        let iconSuffix = myCity.img
        var temp_f = KelvintoFahrenheit(kelvin: (myCity.temp_report.temp))
        // Display the temperature without the decimal
        let temp_i = Int(temp_f)
        let url = "http://openweathermap.org/img/w/"+iconSuffix+".png"

        temp_f = temp_f.rounded()
        if myCity.isCurrentCity {
            cell.yourLocationImage?.isHidden = false
            cell.yourLocationLabel?.isHidden = false
        } else {
            cell.yourLocationImage?.isHidden = true
            cell.yourLocationLabel?.isHidden = true
        }
        cell.nameLabel.text = myCity.name
        cell.tempLabel.text = "\(temp_i)ºF"
        cell.iconImage?.downloaded(from: url)
        return cell
    }    
}


extension ViewController: PresenterToViewProtocol {
    // Success handler for weather API requests
    func showCity(city: City) {
        // Add cities to array
        self.cities.append(city)
        // Refresh the view with updated data
        self.tableView?.reloadData()
    }
    // City fetch error handler
    func showError() {
        //hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

