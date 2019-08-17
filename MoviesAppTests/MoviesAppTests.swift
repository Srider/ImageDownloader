//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import XCTest
import Alamofire
import ObjectMapper

@testable import MoviesApp

class MoviesAppTests: XCTestCase, PresenterToViewProtocol {
    var imagePresenter:ViewToPresenterProtocol?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchDiscoverMovies() {
        imagePresenter?.fetchImagesBasedOnSelection(0, andPage: 1)
    }
    
    func testFetchNowPlayingMovies() {
        imagePresenter?.fetchImagesBasedOnSelection(1, andPage: 1)
    }
    
    func testFetchPopularMovies() {
        imagePresenter?.fetchImagesBasedOnSelection(2, andPage: 1)
    }
    
    func testFetchTopRatedMovies() {
        imagePresenter?.fetchImagesBasedOnSelection(3, andPage: 1)
    }
    
    func showImages(imageArray: Array<Image>) {
        XCTAssertTrue(imageArray.count>0)
    }
    
    func showError() {
        XCTFail()
    }
}
