//
//  NewsViewModel.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public struct NewsViewModel{
    
    private let dateFormatter: DateFormatter = DateFormatter()
    private let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    private var publishTime: String = ""
    private var timeDisplay: String = ""
    private var author: String = ""
    private var title: String = ""
    private var description: String = ""
    private var content: String = ""
    private var source: String = ""
    
    public init(_ news: News){
        
        dateFormatter.dateFormat    = dateFormat
        
        if let publishTime = news.publishedAt,
            let time = dateFormatter.date(from: publishTime)
        {
            self.publishTime = publishTime
            self.timeDisplay = time.timeDisplay()
        }
        
        if let author = news.author{
            self.author = author
        }
        
        if let title = news.title{
            self.title = title
        }
        
        if let description = news.description{
            self.description = description
        }
        
        if let content = news.content{
            self.content = content
        }
        
        if let source = news.source.id{
            self.source = source
        }
        
    }
    
    mutating func updateTimeView(){
        
        if let time = dateFormatter.date(from: self.publishTime){
            self.timeDisplay = time.timeDisplay()
        }
        
    }
    
    func getTime() -> String
    {
        return self.timeDisplay
    }
    
    func getAuthor() -> String
    {
        return self.author
    }
    
    func getTitle() -> String
    {
        return self.title
    }
    
    func getDescription() -> String
    {
        return self.description
    }
    
    func getContent() -> String
    {
        return self.content
    }
    
    func getSource() -> String
    {
        return self.source
    }
    
}
