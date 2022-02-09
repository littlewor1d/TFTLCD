//
//  NetworkManager.swift
//  StocksApp
//
//  Created by Alexey Grebennikov on 18.05.21.
//

import Foundation

class NetworkManager {
    
    func loadCompanyInfo(for symbol: String, completion: @escaping ((Company) -> Void)) -> Void {
        let session = URLSession(configuration: .default)
        let token = "pk_fa4c0a3c281647c8b3ea5c457f3ca46a"
 