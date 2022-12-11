//
//  MainModulBuilder.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//
import UIKit


final public class MainModulBuider {
    public static func build() -> UINavigationController {
        let CDManager = CoreDataManager()
        let interactor = MainInteractor(coreData: CDManager)
        let router = MainRouter(coreData: CDManager)
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        interactor.presenter = presenter
        router.navigationController = navigationController
        
        return navigationController
    }
}

