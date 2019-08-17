//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import UIKit

class ImagesPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func fetchImagesBasedOnSelection(_ selection:Int, andPage pageNumber:Int!) {
        interactor?.fetchImagesBasedOnSelection(selection, andPage: pageNumber)
    }
    
    func showImageController(navigationController: UINavigationController) {
        router?.pushToImageScreen(navigationConroller:navigationController)
    }
    
}

extension ImagesPresenter: InteractorToPresenterProtocol{
    func imageFetchSuccess(imageArray: Array<Image>) {
        view?.showImages(imageArray: imageArray)
    }
    
    func imageFetchFailed() {
        view?.showError()
    }
}
