//
//  MovieProtocols.swift
//  MovieApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchImagesBasedOnSelection(_ selection:Int, andPage pageNumber:Int!)
    func showImageController(navigationController:UINavigationController)
}

protocol PresenterToViewProtocol: class{
    func showImages(imageArray:Array<Image>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> ImagesViewController
    func pushToImageScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchImagesBasedOnSelection(_ selection:Int!, andPage pageNumber:Int!)
    
}

protocol InteractorToPresenterProtocol: class {
    func imageFetchSuccess(imageArray:Array<Image>)
    func imageFetchFailed()
}
