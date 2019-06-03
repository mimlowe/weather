//
//  WeatherProtocol.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//
import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingCity()
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
    func fetchCity()
}

protocol InteractorToPresenterProtocol: class {
    func cityFetchedSuccess(city:City)
    func cityFetchFailed()
}
