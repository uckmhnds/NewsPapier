//
//  FinanceRequest.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/18/23.
//

import Foundation

public struct FinanceRequest: ExternalAPIRequest{
    
    public typealias Response = FinanceResponse
    
    public var hostName: String { return "https://yfinance-stock-market-data.p.rapidapi.com/stock-info" }
    
    public var resourceName: String { return "symbol=\(self.caseCode)&period=\(self.period)" }
    
    public var caseCode: String = ""
    public var period: String = ""
    
    private let timeOutInterval: Double = 10.0
    
    private let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "25e826d57fmsh8808acb1d1e86acp171eb4jsn976d275aaedc",
        "X-RapidAPI-Host": "yfinance-stock-market-data.p.rapidapi.com"
    ]
    
    private let httpMethod: String = "POST"
    
    public init(_case: FinanceCase,
                period: String) {
        
        self.caseCode = _case.code
        self.period = period
        
    }
    
    func request() -> URLRequest{

        let postData = NSMutableData(data: self.resourceName.data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: self.hostName)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: self.timeOutInterval)
        
        request.httpMethod = self.httpMethod
        request.allHTTPHeaderFields = self.headers
        request.httpBody = postData as Data
        
        return request as URLRequest
    }
    
}

public struct FinanceHistoryRequest: ExternalAPIRequest{
    
    public typealias Response = FinanceResponse
    
    public var hostName: String { return "https://yfinance-stock-market-data.p.rapidapi.com/price-customdate" }
    
    public var resourceName: String { return "symbol=\(self.caseCode)&period=1d&start=2023-01-12&end=2023-01-18" }
    
    public var caseCode: String = ""
    public var period: String = ""
    
    private let timeOutInterval: Double = 10.0
    
    private let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "25e826d57fmsh8808acb1d1e86acp171eb4jsn976d275aaedc",
        "X-RapidAPI-Host": "yfinance-stock-market-data.p.rapidapi.com"
    ]
    
    private let httpMethod: String = "POST"
    
    public init(_case: FinanceCase,
                period: String) {
        
        self.caseCode = _case.code
        self.period = period
        
    }
    
    func request() -> URLRequest{

        let postData = NSMutableData(data: self.resourceName.data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: self.hostName)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: self.timeOutInterval)
        
        request.httpMethod = self.httpMethod
        request.allHTTPHeaderFields = self.headers
        request.httpBody = postData as Data
        
        return request as URLRequest
    }
    
}

