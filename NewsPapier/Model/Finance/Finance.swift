//
//  Finance.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/18/23.
//

import Foundation

public struct Finance: Codable, Hashable{
    
    let country: String
    let currency: String
    let currentPrice: Double
    let dayHigh: Double
    let dayLow: Double
    let fiftyDayAverage: Double
    let fiftyTwoWeekHigh : Double
    let fiftyTwoWeekLow : Double
    let fullTimeEmployees : Int
    let industry :  String
    let logo_url : String
    let longBusinessSummary: String
    let longName :  String
    let market :  String
    let marketCap : Int
    let open : Double
    let preMarketPrice : Double
    let previousClose : Double
    let regularMarketDayHigh : Double
    let regularMarketDayLow : Double
    let regularMarketOpen : Double
    let regularMarketPreviousClose : Double
    let regularMarketPrice : Double
    let regularMarketVolume : Double
    let sector :  String
    let symbol :  String
    let targetHighPrice : Double
    let targetLowPrice : Double
    let targetMeanPrice : Double
    
    var change: String {
        
        let numericChange: Double = 100.0 * (self.currentPrice - self.previousClose) / (self.currentPrice)
        
        return "\(Double(round(10 * numericChange) / 10))%"
    }
    
    var increased: Bool {
        return self.currentPrice > self.previousClose ? true : false
    }
    
    var price: String {
        let price = Double(round(10 * currentPrice) / 10)
        
        return "$\(String(price))"
    }
    
    var low: String {
        let price = Double(round(10 * dayLow) / 10)
        
        return "$\(String(price))"
    }
    
    var high: String {
        let price = Double(round(10 * dayHigh) / 10)
        
        return "$\(String(price))"
    }
}

public struct FinanceHistory: Codable, Hashable {
    let Close: Double
    let Date: Int
}
