//
//  ViewController.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var iconImage: UIImageView?
    
    var presentor:ViewToPresenterProtocol?
    var myCity: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        print("here")
        self.title = "Weather"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        presentor?.startFetchingCurrentCity(loc: locValue)
    }


}

extension ViewController: PresenterToViewProtocol{
    
    func showCity(city: City) {
        
        self.myCity = city
        self.nameLabel!.text = myCity?.name
        let iconSuffix = myCity?.img
        var temp_f = KelvintoFahrenheit(kelvin: (myCity?.temp_report.temp)!)
        
        temp_f = temp_f.rounded()
        self.tempLabel!.text = "\(temp_f)ºF"
        print(iconSuffix)
        let url = "http://openweathermap.org/img/w/"+iconSuffix!+".png"
        self.iconImage?.downloaded(from: url)
    
        //self.uiTableView.reloadData()
        //hideProgressIndicator(view: self.view)
    }
    
    func showError() {
        //hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

