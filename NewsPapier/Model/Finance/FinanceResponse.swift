//
//  FinanceResponse.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/18/23.
//

import Foundation

public struct FinanceResponse: Codable, Hashable{
    let data: Finance
    let message: String
    let status: Int
}

public struct FinanceHistoryResponse: Codable, Hashable{
    let data: [FinanceHistory]
    let message: String
    let status: Int
}
