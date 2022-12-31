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
    
    var timeView: String {
        
        let dateFormatter: DateFormatter = DateFormatter()
        let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        dateFormatter.dateFormat = dateFormat
        
        if let publishTime = publishedAt,
            let time = dateFormatter.date(from: publishTime)
        {
            return time.timeDisplay()
        }
        
        return ""
    }
    
}






