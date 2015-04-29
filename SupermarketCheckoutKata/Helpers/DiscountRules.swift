//
//  DiscountRules.swift
//  SupermarketCheckoutKata
//
//  Created by Matthew Healy on 29/04/2015.
//  Copyright (c) 2015 Matthew Healy. All rights reserved.
//

import Foundation

typealias DiscountRule = (numberOfItems: Int, itemPrice: Int) -> Int

class DiscountRules {
    
    static let buyTwoGetOneFree: DiscountRule = {
        (numberOfItems: Int, itemPrice: Int) -> Int in
        
        let numberOfGroupsOfThreeItems = numberOfItems / 3
        let remainderOfItems = numberOfItems % 3
        
        return (2 * numberOfGroupsOfThreeItems + remainderOfItems) * itemPrice
    }
    
    static func twoItemsFor(#multibuyCost: Int) -> DiscountRule {
        return { (numberOfItems: Int, itemPrice: Int) -> Int in
            
            let numberOfGroupsOfTwoItems = numberOfItems / 2
            let remainderOfItems = numberOfItems % 2
            
            return (numberOfGroupsOfTwoItems * multibuyCost) + (remainderOfItems * itemPrice)
        }
    }
    
}