//
//  WeatherPresenter.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WeatherPresenter:ViewToPresenterProtocol {
    // Protocols
    var view:       PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router:     PresenterToRouterProtocol?
    // Hard coded example city requests
    func startFetchingTokyo() {
        interactor?.fetchTokyo()
    }
    
    func startFetchingLondon() {
        interactor?.fetchLondon()
    }
    // Presenter protocol method for fetching data from user's lat/long
    func startFetchingCurrentCity(loc: CLLocationCoordinate2D) {
        interactor?.fetchCurrentCity(loc: loc)
    }
    
    func showCityController(navigationController: UINavigationController) {
        router?.pushToCityScreen(navigationConroller:navigationController)
    }
    
}

extension WeatherPresenter: InteractorToPresenterProtocol{
    // Success handler bridge for weather API requests
    func cityFetchedSuccess(city: City) {
        view?.showCity(city: city)
    }
    // Request failier bridge for weather API requests
    func cityFetchFailed() {
        view?.showError()
    }
    
}
