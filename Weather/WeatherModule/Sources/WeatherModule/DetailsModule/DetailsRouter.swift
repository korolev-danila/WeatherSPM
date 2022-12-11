//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import UIKit

protocol DetailsRouterProtocol: AnyObject {

    func popVC()
}

final class DetailsRouter {
    weak var navigationController: UINavigationController?
    
    init(nc: UINavigationController) {
        self.navigationController = nc
    }
    
    deinit {
        print("deinit DetailsRouterProtocol")
    }
}


extension DetailsRouter: DetailsRouterProtocol {
    
    public func popVC() {
        self.navigationController?.popViewController(animated: true)
    }    
}
