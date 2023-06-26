//
//  Order.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAdress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAdress: Bool {
         !(name.isEmpty || streetAdress.isEmpty || city.isEmpty || zip.isEmpty)
    }
}
