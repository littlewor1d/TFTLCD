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
        guard let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?token=\(token)") else { return }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
               (response as? HTTPURLResponse)?.statusCode == 200,
               error == nil {
                
                do {
                    let company = try JSONDecoder().decode(Company.self, from: data)
                    DispatchQueue.main.async {
                        completion(compa