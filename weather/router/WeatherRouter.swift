//
//  WeatherRouter.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import Foundation
import UIKit

class WeatherRouter:PresenterToRouterProtocol{
    
    static func createModule() -> ViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = WeatherPresenter()
        let interactor: PresenterToInteractorProtocol = WeatherInteractor()
        let router:PresenterToRouterProtocol = WeatherRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToCityScreen(navigationConroller navigationController:UINavigationController) {
        
        let cityModue = WeatherRouter.createModule()
        navigationController.pushViewController(cityModue, animated: true)
        
    }
    
}
