//
//  MainModulBuilder.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//
import UIKit


final public class MainModulBuider {
    public static func build() -> UINavigationController {
        let cdManager = CoreDataManager()
        let netManager = NetworkManager()
        let interactor = MainInteractor(coreData: cdManager, network: netManager)
        let router = MainRouter(coreData: cdManager, network: netManager)
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        interactor.presenter = presenter
        router.navigationController = navigationController
        
        return navigationController
    }
}

