//
//  MoviesRouter.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import UIKit

class MoviesRouter:PresenterToRouterProtocol{
    
    static func createModule() -> MoviesViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MoviesPresenter()
        let interactor: PresenterToInteractorProtocol = MoviesInteractor()
        let router:PresenterToRouterProtocol = MoviesRouter()
        
        view.moviePresenter = presenter
        presenter.view = view as PresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
        
        let movieModue = MoviesRouter.createModule()
        navigationController.pushViewController(movieModue,animated: true)
        
    }
    
}
