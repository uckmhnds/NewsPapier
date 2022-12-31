//
//  NewsResponse.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public struct NewsResponse: Codable, Hashable{
    let articles: [News]?
    let status: String?
    let code: String?
    let message: String?
}
