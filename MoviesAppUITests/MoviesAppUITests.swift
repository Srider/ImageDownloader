//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import XCTest

class MoviesAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
    }

    func testDiscoverTabNextPage() {
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"Discover").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 0).swipeUp()
    }
    
    //Working
    func testNowPlayingTabNextPage() {
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Discover").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 1).children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        
        let collectionView = app.otherElements.containing(.navigationBar, identifier:"Now Playing").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 0)
        collectionView.swipeUp()
    }
    
    func testPopularTabNextPage() {

        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Discover").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 1).children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
        app.otherElements.containing(.navigationBar, identifier:"Popular").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 0).swipeUp()
    }
  
    func testTopRatedTabNextPage() {
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Discover").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 1).children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.tap()
        app.otherElements.containing(.navigationBar, identifier:"Top Rated").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 0).swipeUp()
    }
}

