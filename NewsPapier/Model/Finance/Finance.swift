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
}


