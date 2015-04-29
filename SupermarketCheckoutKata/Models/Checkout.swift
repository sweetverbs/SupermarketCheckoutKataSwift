//
//  Checkout.swift
//  SupermarketCheckoutKata
//
//  Created by Matthew Healy on 29/04/2015.
//  Copyright (c) 2015 Matthew Healy. All rights reserved.
//

import Foundation

class Checkout {
    
    static func forProducts(products: [ProductRecord]) -> Checkout {
        let checkout = Checkout()
        for product in products {
            checkout.addProduct(product)
        }
        return checkout
    }
    
    var scannedProducts: [String : Int] = [ : ]
    var productRecords: [String : ProductRecord] = [ : ]
    
    // MARK: scanning
    
    func scan(productName: String) {
        let productScanned = self.scannedProducts.keys.filter {
            (key: String) -> Bool in
            key == productName
        }.array
        
        if count(productScanned) != 1 { return }
        
        self.scannedProducts[productScanned[0]]! += 1
    }
    
    func scan(productNames: [String]) {
        for productName in productNames {
            self.scan(productName)
        }
    }
    
    // MARK: cost and savings
    
    func totalCost() -> Int {
        return self.productRecords.values.map {
            (p: ProductRecord) -> Int in
            p.costFor(self.scannedProducts[p.name]!)
            }.array.reduce(0, combine: +)
    }
    
    func totalSaving() -> Int {
        return self.productRecords.values.map {
            (p: ProductRecord) -> Int in
            p.savingFor(self.scannedProducts[p.name]!)
            }.array.reduce(0, combine: +)
    }
    
    // MARK: adding new products
    
    func addProduct(product: ProductRecord) {
        if self.scannedProducts[product.name] != nil { return }
        
        self.productRecords[product.name] = product
        self.scannedProducts[product.name] = 0
    }
    
}