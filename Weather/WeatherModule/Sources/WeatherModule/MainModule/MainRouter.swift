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
    
    public func pushSearchView(delegate: MainPresenterDelegate) {
        let vc =  SearchModulBuider.build(delegate: delegate, netManager: networkManager)
        navigationController?.showDetailViewController(vc, sender: nil)
    }
    
    public func pushDetailsView(city: City) {
        if let nc = navigationController {
            let vc = DetailsModulBuider.build(nc: nc, city: city, cdManager: coreDataManager, netManager: networkManager)
            print("push Details")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
