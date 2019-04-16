

//
//  TradingData]].swift
//  Crypto Lombard
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 16/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class FinancialProduct{
    let product : Currency
    
    private var against : [Currency]
    var data      : [JSON]
    var error     : String?
    
    
    init(product : Currency){
        self.product = product
        against = []
        self.data = []
        self.error = nil
    }
    
    func updateData(completion: @escaping((Bool)->Void)){
        for (index, currency) in against.enumerated(){
            let finalURL : String = "https://apiv2.bitcoinaverage.com/indices/global/ticker/" + product.name + currency.name
            print(finalURL)
            Alamofire.request(finalURL, method: .get).responseJSON {
                response in
                if response.result.isSuccess{
                    //has got a response, might be 404...
                    let reqJSON : JSON = JSON(response.result.value!)
                    print(index)
                    //TODO: check if response is good
                    self.data[index] = reqJSON
                    //todo: remove the print
                    print(self.data[index])
                    completion(true)
                }
                else{
                    print("networking error")
                    self.error = ("An networking error has occurred, this is likely due to poor connection")
                    completion(true)
                }
            }
        }
    }
    
    func addCurrency(currency : Currency){
        against.append(currency)
        data.append(JSON.init())
    }
    
    
    func getImageName() -> String{
        return product.imageName
    }
    
}
