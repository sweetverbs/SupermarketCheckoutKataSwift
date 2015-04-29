//
//  DiscountRulesTests.swift
//  SupermarketCheckoutKata
//
//  Created by Matthew Healy on 29/04/2015.
//  Copyright (c) 2015 Matthew Healy. All rights reserved.
//

import UIKit
import XCTest

class DiscountRulesTests: XCTestCase {
    
    var buyTwoGetOneFree: DiscountRule!
    var twoItemsForFivePounds: DiscountRule!
    
    override func setUp() {
        super.setUp()
        
        buyTwoGetOneFree = DiscountRules.buyTwoGetOneFree
        twoItemsForFivePounds = DiscountRules.twoItemsFor(multibuyCost: 500)
    }
    
    // MARK: buyTwoGetOneFree tests

    func testBTGOFReturnsZeroForNoItems() {
        let cost = buyTwoGetOneFree(numberOfItems: 0, itemPrice: 100)
        XCTAssertEqual(cost, 0)
    }
    
    func testBTGOFReturnsPriceForOneItem() {
        let cost = buyTwoGetOneFree(numberOfItems: 1, itemPrice: 100)
        XCTAssertEqual(cost, 100)
    }
    
    func testBTGOFReturns2xPriceForTwoItems() {
        let cost = buyTwoGetOneFree(numberOfItems: 2, itemPrice: 100)
        XCTAssertEqual(cost, 200)
    }
    
    func testBTGOFReturns2xPriceForThreeItems() {
        let cost = buyTwoGetOneFree(numberOfItems: 3, itemPrice: 100)
        XCTAssertEqual(cost, 200)
    }
    
    func testBTGOFReturns4xPriceForSixItems() {
        let cost = buyTwoGetOneFree(numberOfItems: 6, itemPrice: 100)
        XCTAssertEqual(cost, 400)
    }
    
    func testBTGOFReturns7xPriceForTenItems() {
        let cost = buyTwoGetOneFree(numberOfItems: 10, itemPrice: 100)
        XCTAssertEqual(cost, 700)
    }
    
    // MARK: twoItemsForFivePounds test
    
    func testTIFFPReturnsZeroForNoItems() {
        let cost = twoItemsForFivePounds(numberOfItems: 0, itemPrice: 350)
        XCTAssertEqual(cost, 0)
    }
    
    func testTIFFPReturnsPriceForOneItem() {
        let cost = twoItemsForFivePounds(numberOfItems: 1, itemPrice: 350)
        XCTAssertEqual(cost, 350)
    }
    
    func testTIFFPReturnsMultibuyCostForTwoItems() {
        let cost = twoItemsForFivePounds(numberOfItems: 2, itemPrice: 350)
        XCTAssertEqual(cost, 500)
    }
    
    func testTIFFPReturnsMultibuyCostPlusItemPriceForThreeItems() {
        let cost = twoItemsForFivePounds(numberOfItems: 3, itemPrice: 350)
        XCTAssertEqual(cost, 850)
    }

}
