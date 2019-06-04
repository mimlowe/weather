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
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var iconImage: UIImageView?
    @IBOutlet weak var tableView: UITableView?
    
    var presentor:ViewToPresenterProtocol?
    var cities:Array<City> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
        presentor?.startFetchingCity(name: "London")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let loc: CLLocationCoordinate2D = location.coordinate
            presentor?.startFetchingCurrentCity(loc: loc)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Prevents the table view from attempting to load rows from an empty data source
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let myCity = cities[indexPath.item]
        let iconSuffix = myCity.img
        var temp_f = KelvintoFahrenheit(kelvin: (myCity.temp_report.temp))
        temp_f = temp_f.rounded()
        print(iconSuffix)
        let url = "http://openweathermap.org/img/w/"+iconSuffix+".png"
        cell.nameLabel.text = myCity.name
        cell.tempLabel.text = "\(temp_f)ºF"
        cell.iconImage?.downloaded(from: url)
        return cell
    }
    
}


extension ViewController: PresenterToViewProtocol {
    
    func showCity(city: City) {
        print("handling city info")
        print(city)
        self.cities.append(city)
        self.tableView?.reloadData()
    }
    
    func showError() {
        //hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

