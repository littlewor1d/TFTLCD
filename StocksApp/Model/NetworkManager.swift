//
//  NetworkManager.swift
//  StocksApp
//
//  Created by Alexey Grebennikov on 18.05.21.
//

import Foundation

class NetworkManager {
    
    func loadCompanyInfo(for symbol: String, completion: @escaping ((Company) -> Void)) -> Void {
        let session = URLSession(configuration: .defa