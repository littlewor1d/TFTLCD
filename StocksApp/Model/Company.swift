//
//  Company.swift
//  StocksApp
//
//  Created by Alexey Grebennikov on 18.05.21.
//

import Foundation

struct Company: Decodable {
    
    var name: String
    var symbol: String
    var latestPrice: Double
    var priceChange: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "companyName"
        case symbol
        case latestPrice
        case priceChange = "change"
    }
    
}


