//
//  StarWarsCodeChallengeTests.swift
//  StarWarsCodeChallengeTests
//
//  Created by Perez Willie Nwobu on 12/4/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import XCTest
@testable import StarWarsCodeChallenge
class StarWarsCodeChallengeTests: XCTestCase {
    
    
    func testSavingToPersistance() {
        let jediVM = JediViewModel.shared
        
        let firstCount = jediVM.savedResults.count
        
        let testResult = Result(name: "Hello Test", height: "jdhv", mass: "dhbd", hair_color: "kdhbf", skin_color: "ldsjh", eye_color: "dkfhb", birth_year: "djhfb", gender: "djhkfb", created: "yestertday")
        
        jediVM.saveResult(result: testResult)
        jediVM.loadFromPersistence()
        let secondCount = jediVM.savedResults.count
        
        XCTAssertNotEqual(firstCount, secondCount)
    }
    
    func testDeletingToPersistance() {
        let jediVM = JediViewModel.shared
        
        let firstCount = jediVM.savedResults.count
        let testResult = Result(name: "Hello Test", height: "jdhv", mass: "dhbd", hair_color: "kdhbf", skin_color: "ldsjh", eye_color: "dkfhb", birth_year: "djhfb", gender: "djhkfb", created: "yestertday")
        
        jediVM.saveResult(result: testResult)
        jediVM.loadFromPersistence()
        let secondCount = jediVM.savedResults.count
        jediVM.deleteResult(result: testResult)
        jediVM.loadFromPersistence()
        
        XCTAssertEqual(firstCount, secondCount)
    }
    
    func testURLString(){
        XCTAssertEqual(String.url, "https://swapi.co/api/people/")
    }
    
    func testUIIMages(){
        XCTAssertEqual(UIImage.selected, UIImage(named: "selected"))
        XCTAssertEqual(UIImage.nonSelected, UIImage(named: "nonSelected"))
    }
}
