//
//  API.swift
//  ExchangeApp
//
//  Created by MacBook Air on 01/06/2020.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    enum APIErrors: Error{
        case JSONDecodeErrror
        case NetworkError
    }
    static func getRate(from: String, to: String, resultHandler: @escaping  (Result<Float, Error>) -> ()) {
        let params : [String:Any] = ["base":from,
                                     "symbols":to
        ]
        let urlString = "https://api.exchangeratesapi.io/latest"
        AF.request(urlString, method: .get, parameters: params).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
            case .success(let resp):
                let json = JSON(resp)
                guard let rate = json["rates",to].float else {
                    resultHandler(.failure(APIErrors.JSONDecodeErrror))
                    return
                }
                resultHandler(.success(rate))
            case.failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
}
