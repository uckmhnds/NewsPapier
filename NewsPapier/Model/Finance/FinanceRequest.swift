//
//  FinanceRequest.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/18/23.
//

import Foundation

public struct FinanceRequest: ExternalAPIRequest{
    
    public typealias Response = FinanceResponse
    
    public var hostName: String { return "" }
    
    public var resourceName: String { return "" }
    
    public var body: String = ""
    
    public init() {
        
    }
    
    func request() -> URLRequest{
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "25e826d57fmsh8808acb1d1e86acp171eb4jsn976d275aaedc",
            "X-RapidAPI-Host": "yfinance-stock-market-data.p.rapidapi.com"
        ]

        let postData = NSMutableData(data: "symbol=AAPL".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://yfinance-stock-market-data.p.rapidapi.com/stock-info")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        return request as URLRequest
    }
    
}
