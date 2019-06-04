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
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingTokyo() {
        interactor?.fetchTokyo()
    }
    
    func startFetchingLondon() {
        interactor?.fetchLondon()
    }
    
    func startFetchingCurrentCity(loc: CLLocationCoordinate2D) {
        interactor?.fetchCurrentCity(loc: loc)
    }
    
    func showCityController(navigationController: UINavigationController) {
        router?.pushToCityScreen(navigationConroller:navigationController)
    }
    
}

extension WeatherPresenter: InteractorToPresenterProtocol{
    
    func cityFetchedSuccess(city: City) {
        view?.showCity(city: city)
    }
    
    func cityFetchFailed() {
        view?.showError()
    }
    
}
