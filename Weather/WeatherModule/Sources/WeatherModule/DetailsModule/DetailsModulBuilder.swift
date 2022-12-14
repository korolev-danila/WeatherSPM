//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import UIKit

final class DetailsModulBuider {
    public static func build(nc: UINavigationController, city: City,cdManager: CoreDataManagerProtocol,
                             netManager: NetworkManagerProtocol) -> DetailsViewController {
        let interctor = DetailsInteractor(coreData: cdManager, network: netManager)
        let router = DetailsRouter(nc: nc)
        let presenter = DetailsPresenter(interactor: interctor, router: router, city: city)
        let viewController = DetailsViewController(presenter: presenter)
        presenter.view = viewController
        interctor.presenter = presenter
        
        return viewController
    }
}
