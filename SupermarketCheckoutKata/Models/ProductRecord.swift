//
//  SupermarketItem.swift
//  SupermarketCheckoutKata
//
//  Created by Matthew Healy on 28/04/2015.
//  Copyright (c) 2015 Matthew Healy. All rights reserved.
//

import Foundation

class ProductRecord {
    
    let name: String
    let price: Int
    private let discountRule: DiscountRule?
    
    init(name: String, price: Int, discountRule: DiscountRule?) {
        self.name = name
        self.price = price
        self.discountRule = discountRule
    }
    
    convenience init(name: String, price: Int) {
        self.init(name: name, price: price, discountRule: nil)
    }
    
    func costFor(n: Int) -> Int {
        if let discountRule = self.discountRule {
            return discountRule(numberOfItems: n, itemPrice: self.price)
        }
        
        return n * self.price
    }
    
    func savingFor(n: Int) -> Int {
        return (n * price) - self.costFor(n)
    }

}