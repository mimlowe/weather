//
//  WeatherProtocol.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingTokyo()
    func startFetchingLondon()
    func startFetchingCurrentCity(loc: CLLocationCoordinate2D)
    func showCityController(navigationController:UINavigationController)
    
}

protocol PresenterToViewProtocol: class{
    func showCity(city:City)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> ViewController
    func pushToCityScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchTokyo()
    func fetchLondon()
    func fetchCurrentCity(loc: CLLocationCoordinate2D)
}

protocol InteractorToPresenterProtocol: class {
    func cityFetchedSuccess(city:City)
    func cityFetchFailed()
}
