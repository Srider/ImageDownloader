//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import UIKit

class MoviesPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func fetchMoviesBasedOnSelection(_ selection:Int, andPage pageNumber:Int!) {
        interactor?.fetchMoviesBasedOnSelection(selection, andPage: pageNumber)
    }
    
    func showMovieController(navigationController: UINavigationController) {
        router?.pushToMovieScreen(navigationConroller:navigationController)
    }
    
}

extension MoviesPresenter: InteractorToPresenterProtocol{
    func movieFetchSuccess(movieArray: Array<Movie>) {
        view?.showMovies(movieArray: movieArray)
    }
    
    func movieFetchFailed() {
        view?.showError()
    }
}
