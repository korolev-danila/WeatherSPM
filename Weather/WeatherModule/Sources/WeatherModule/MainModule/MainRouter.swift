//
//  MainRouter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    func pushSearchView(delegate: MainPresenterDelegate)
    func pushDetailsView(city: City)
}

final class MainRouter {
    weak var navigationController: UINavigationController?
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    init(coreData: CoreDataManagerProtocol, network: NetworkManagerProtocol){
        self.coreDataManager = coreData
        self.networkManager = network
    }
}

// MARK: - MainRouterProtocol
extension MainRouter: MainRouterProtocol{
    func pushSearchView(delegate: MainPresenterDelegate) {
        let vc = SearchModulBuider.build(delegate: delegate, netManager: networkManager)
        navigationController?.showDetailViewController(vc, sender: nil)
    }
    
    func pushDetailsView(city: City) {
        if let navigationController {
            let vc = DetailsModulBuider.build(nc: navigationController, city: city,
                                              cdManager: coreDataManager, netManager: networkManager)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
