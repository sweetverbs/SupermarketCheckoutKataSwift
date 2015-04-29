//
//  SupermarketItemTests.swift
//  SupermarketCheckoutKata
//
//  Created by Matthew Healy on 28/04/2015.
//  Copyright (c) 2015 Matthew Healy. All rights reserved.
//

import UIKit
import XCTest

class ProductRecordTests: XCTestCase {
    
    var biscuits: ProductRecord!
    var discountJuice: ProductRecord!
    
    override func setUp() {
        biscuits = ProductRecord(name: "biscuits", price: 129)
        discountJuice = ProductRecord(name: "Can of juice", price: 53, discountRule: DiscountRules.buyTwoGetOneFree)
    }
    
    // MARK: init tests

    func testCanInitWithItemNameAndPrice() {
        XCTAssertEqual(biscuits.name, "biscuits")
        XCTAssertEqual(biscuits.price, 129)
    }
    
    func testCanInitWithDifferentNameAndPrice() {
        let canOfJuice = ProductRecord(name: "Can of juice", price: 53)
        XCTAssertEqual(canOfJuice.name, "Can of juice")
        XCTAssertEqual(canOfJuice.price, 53)
    }
    
    // MARK: cost tests
    
    func testCanInitWithDiscountRuleAndGetDiscountedCost() {
        let costOfTwoCans = discountJuice.costFor(2)
        let costOfThreeCans = discountJuice.costFor(3)
        
        XCTAssertEqual(costOfTwoCans, 106)
        XCTAssertEqual(costOfThreeCans, 106)
    }
    
    func testCanGetCostWithNoDiscountRule() {
        XCTAssertEqual(biscuits.costFor(1), 129)
        XCTAssertEqual(biscuits.costFor(2), 129 * 2)
        XCTAssertEqual(biscuits.costFor(3), 129 * 3)
    }
    
    // MARK: savings tests
    
    func testSavingFor0ItemsReturns0() {
        let saving = discountJuice.savingFor(0)
        XCTAssertEqual(saving, 0)
    }
    
    func testSavingFor3ItemsReturns53() {
        let saving = discountJuice.savingFor(3)
        XCTAssertEqual(saving, 53)
    }
    
    func testSavingFor4ItemsReturns53() {
        let saving = discountJuice.savingFor(4)
        XCTAssertEqual(saving, 53)
    }
    
    func testSavingFor6ItemsReturns106() {
        let saving = discountJuice.savingFor(6)
        XCTAssertEqual(saving, 106)
    }
    
    func testSavingForUndiscountedItemAlwaysReturns0() {
        let saving = biscuits.savingFor(150)
        XCTAssertEqual(saving, 0)
    }
    
}