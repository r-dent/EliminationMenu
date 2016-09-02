//
//  EliminationMenuTests.swift
//  EliminationMenuTests
//
//  Created by Roman Gille on 02.09.16.
//  Copyright © 2016 Roman Gille. All rights reserved.
//

import XCTest
@testable import EliminationMenu

class EliminationMenuTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLayoutMargins() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        guard let view = viewController?.view else {
            XCTFail("Could not get view")
            return
        }
        
        
        let menuItems = [
            EliminationMenu.Item(value: UIColor(red: 57/255, green: 61/255, blue: 66/255, alpha: 1) , title: "Gray"),
            EliminationMenu.Item(value: UIColor.blueColor(), title: "Blue"),
            EliminationMenu.Item(value: UIColor.redColor(), title: "Red"),
            EliminationMenu.Item(value: UIColor.greenColor(), title: "Green")
        ]
        
        let margin = CGPoint(x: 12, y: 24)
        
        let menu = EliminationMenu.createMenu(
            withItems: menuItems,
            inView: view,
            aligned: .TopLeft,
            margin: margin,
            selection: nil
        )
        
        view.layoutSubviews()
        
        XCTAssertEqual(menu.frame.origin.x, margin.x, "Margin x does not match")
        XCTAssertEqual(menu.frame.origin.y, margin.y, "Margin y does not match")
        
    }
    
}
