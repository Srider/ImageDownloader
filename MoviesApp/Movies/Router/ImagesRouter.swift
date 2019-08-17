//
//  MoviesRouter.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import UIKit

class ImagesRouter:PresenterToRouterProtocol{
    
    static func createModule() -> ImagesViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ImagesViewController") as! ImagesViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ImagesPresenter()
        let interactor: PresenterToInteractorProtocol = ImagesInteractor()
        let router:PresenterToRouterProtocol = ImagesRouter()
        
        view.imagePresenter = presenter
        presenter.view = view as PresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToImageScreen(navigationConroller navigationController:UINavigationController) {
        
        let imageModue = ImagesRouter.createModule()
        navigationController.pushViewController(imageModue,animated: true)
        
    }
    
}
