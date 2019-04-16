//
//  variables.swift
//  Crypto Lombard
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 16/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation


var fiatCurrency : [Currency] = []
var cryptoCurrency : [Currency] = []

var financialProduct : [FinancialProduct] = []


func setCurrencies(){
    fiatCurrency.append(Currency(name: "USD", type: .fiat, imageName: "dollar"))
    fiatCurrency.append(Currency(name: "EUR", type: .fiat, imageName: "euro"))
    cryptoCurrency.append(Currency(name: "BTC", type: .crypto, imageName: "bitcoin"))
    cryptoCurrency.append(Currency(name: "ETH", type: .crypto, imageName: "ethereum"))
}


func setFinancialProducts(){
    let bitcoin = FinancialProduct(product: cryptoCurrency[0])
    let etherium = FinancialProduct(product: cryptoCurrency[1])
    financialProduct.append(bitcoin)
    financialProduct.append(etherium)
    financialProduct[0].addCurrency(currency: fiatCurrency[0])
    financialProduct[0].addCurrency(currency: fiatCurrency[1])
    financialProduct[1].addCurrency(currency: fiatCurrency[0])
    financialProduct[1].addCurrency(currency: fiatCurrency[1])
}
