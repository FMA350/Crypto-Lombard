//
//  currencyArray.swift
//  Crypto Lombard
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 15/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum productType {
    case crypto
    case fiat
}

class Currency{
    let name : String
    let type : productType
    let imageName : String
    
    init(name: String, type : productType, imageName : String){
        self.name = name
        self.type = type
        self.imageName = imageName
    }
}
