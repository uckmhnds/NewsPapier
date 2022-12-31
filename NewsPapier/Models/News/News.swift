//
//  News.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import Foundation

public struct News: Codable, Hashable{
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}






