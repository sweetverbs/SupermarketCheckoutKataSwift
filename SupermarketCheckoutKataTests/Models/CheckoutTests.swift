//
//  CheckoutTests.swift
//  SupermarketCheckoutKata
//
//  Created by Matthew Healy on 29/04/2015.
//  Copyright (c) 2015 Matthew Healy. All rights reserved.
//

import UIKit
import XCTest

class CheckoutTests: XCTestCase {
    
    var checkout:                 Checkout!
    var biscuits:                 ProductRecord!
    var canOfJuice:               ProductRecord!
    var microwaveMeal:            ProductRecord!
    var products:                [ProductRecord]!
    var expectedInitialProducts: [String : Int]!
    
    override func setUp() {
        biscuits = ProductRecord(name: "Biscuits", price: 129)
        canOfJuice = ProductRecord(name: "Can of juice", price: 53, discountRule: DiscountRules.buyTwoGetOneFree)
        microwaveMeal = ProductRecord(name: "Microwave meal", price: 350, discountRule: DiscountRules.twoItemsFor(multibuyCost: 500))
        
        products = [biscuits, canOfJuice, microwaveMeal]
        
        checkout = Checkout.forProducts(products)
        
        expectedInitialProducts = ["Biscuits": 0, "Can of juice": 0, "Microwave meal": 0]
    }
    
    // MARK: test factory method

    func testCheckoutForProductsFactory() {
        XCTAssertEqual(checkout.scannedProducts, expectedInitialProducts)
    }
    
    // MARK: test scanning
    
    func testScanningNonExistentItem() {
        checkout.scan("Matthew")
        XCTAssertEqual(checkout.scannedProducts, expectedInitialProducts)
    }
    
    func testScanningSingleItem() {
        checkout.scan("Biscuits")
        XCTAssertNotNil(checkout.scannedProducts["Biscuits"])
        if let numberScanned = checkout.scannedProducts["Biscuits"] {
            XCTAssertEqual(numberScanned, 1)
        }
    }
    
    func testScanningDifferentItem() {
        checkout.scan("Can of juice")
        XCTAssertNotNil(checkout.scannedProducts["Can of juice"])
        if let numberScanned = checkout.scannedProducts["Can of juice"] {
            XCTAssertEqual(numberScanned, 1)
        }
    }
    
    func testScanningWholeCart() {
        let cart = ["Biscuits", "Can of juice", "Can of juice"]
        checkout.scan(cart)
        
        XCTAssertNotNil(checkout.scannedProducts["Biscuits"])
        if let biscuitsScanned = checkout.scannedProducts["Biscuits"] {
            XCTAssertEqual(biscuitsScanned, 1)
        }
        
        XCTAssertNotNil(checkout.scannedProducts["Can of juice"])
        if let juiceScanned = checkout.scannedProducts["Can of juice"] {
            XCTAssertEqual(juiceScanned, 2)
        }
    }
    
    // MARK: test total cost
    
    func testTotalCostIsCorrectForOneItem() {
        checkout.scan("Biscuits")
        XCTAssertEqual(checkout.totalCost(), 129)
    }
    
    func testTotalCostIsCorrectForDifferentItem() {
        checkout.scan("Can of juice")
        XCTAssertEqual(checkout.totalCost(), 53)
    }
    
    func testTotalCostIsCorrectForOneOfEachItem() {
        checkout.scan(["Biscuits", "Can of juice", "Microwave meal"])
        XCTAssertEqual(checkout.totalCost(), 129 + 53 + 350)
    }
    
    func testTotalCostIsCorrectForDiscountedItems() {
        checkout.scan(["Can of juice", "Can of juice", "Can of juice"])
        XCTAssertEqual(checkout.totalCost(), 53 + 53)
    }
    
    func testCostIsCorrectForComplicatedCartInArbitraryOrder() {
        let cart = ["Can of juice", "Biscuits", "Biscuits", "Can of juice", "Microwave meal", "Microwave meal", "Can of juice"]
        checkout.scan(cart)
        XCTAssertEqual(checkout.totalCost(), 864)
    }
    
    // MARK: test savings
    
    func testSavingIs0ForOneItem() {
        checkout.scan("Biscuits")
        XCTAssertEqual(checkout.totalSaving(), 0)
    }
    
    func testSavingReflectsDiscountCorrectly() {
        checkout.scan(["Microwave meal", "Microwave meal"])
        XCTAssertEqual(checkout.totalSaving(), 200)
    }
    
    func testSavingReflectsDiscountOnComplicatedCart() {
        let cart = ["Can of juice", "Biscuits", "Biscuits", "Can of juice", "Microwave meal", "Microwave meal", "Can of juice"]
        checkout.scan(cart)
        XCTAssertEqual(checkout.totalSaving(), 253)
    }
    
    // MARK: test adding new products
    
    func testAddProduct() {
        let rollerskates = ProductRecord(name: "Rollerskates", price: 10000)
        checkout.addProduct(rollerskates)
        
        XCTAssertNotNil(checkout.scannedProducts["Rollerskates"])
        if let numberScanned = checkout.scannedProducts["Rollerskates"] {
            XCTAssertEqual(numberScanned, 0)
        }
    }
    
    func testCannotAddSameProductTwice() {
        checkout.scannedProducts["Biscuits"] = 5
        checkout.addProduct(biscuits)
        
        XCTAssertNotNil(checkout.scannedProducts["Biscuits"])
        if let numberScanned = checkout.scannedProducts["Biscuits"] {
            XCTAssertEqual(numberScanned, 5)
        }
    }
}
