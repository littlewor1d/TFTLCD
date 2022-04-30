
//
//  ViewController.swift
//  StocksApp
//
//  Created by Alexey Grebennikov on 2.05.21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var companySymbolLabel: UILabel!
    @IBOutlet weak var companySymbolImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    //MARK: - Properties
    
    var networkManager = NetworkManager()
    
    private lazy var companies = [
        "Apple": "AAPL",
        "Microsoft": "MSFT",
        "Google": "GOOG",
        "Amazon": "AMZN",
        "Facebook": "FB"
    ]
    
    //MARK: - Lifecylce

    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyPickerView.dataSource = self
        companyPickerView.delegate = self
        
        activityIndicator.hidesWhenStopped = true
        
        requestQuoteUpdate()
        
    }
    
    //MARK: - Network

    private func displayStockInfo(companyName: String,
                                  companySymbol: String,
                                  price: Double,
                                  priceChange: Double) {
        activityIndicator.stopAnimating()
        companyNameLabel.text = companyName
        companySymbolImage.image = UIImage(named: companySymbol)
        companySymbolLabel.text = nil
        priceLabel.text = "\(price)"
        priceChangeLabel.text = "\(priceChange)"
        
        if priceChange > 0 {
            priceChangeLabel.textColor = .green
        } else if priceChange < 0 {
            priceChangeLabel.textColor = .red
        } else {
            priceChangeLabel.textColor = .black
        }
    }
    
    private func requestQuoteUpdate() {
        activityIndicator.startAnimating()
        companyNameLabel.text = "-"
        companySymbolLabel.text = "-"
        priceLabel.text = "-"
        priceChangeLabel.text = "-"
        priceChangeLabel.textColor = .black
        companySymbolImage.image = nil
        
        let selectedRow = companyPickerView.selectedRow(inComponent: 0)
        let selectedSymbol = Array(companies.values)[selectedRow]
        networkManager.loadCompanyInfo(for: selectedSymbol) { [weak self] company in
            self?.displayStockInfo(companyName: company.name,
                                   companySymbol: company.symbol,
                                   price: company.latestPrice,
                                   priceChange: company.priceChange)
            
        }
    }

}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        companies.keys.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Array(companies.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       requestQuoteUpdate()
    }
    
}