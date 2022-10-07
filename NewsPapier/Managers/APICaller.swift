//
//  APICaller.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import Foundation

struct Constants{
    
    static let BASE_URL: String        = "https://newsapi.org/v2/"
    
    static let TOP_HEADLINE: String    = "top-headlines?"
    static let EVERYTHING: String      = "everything?"
    
    static let COUNTRY: String         = "country="
    static let API_KEY: String         = "&apiKey=5b5a47c88e734c448bdbae91ae7389be"
    static let PAGE: String            = "&page="
    static let PAGE_SIZE: String       = "&pageSize="
    static let QUERY: String           = "q="
}

struct Countries{
    static let US: String   = "us"
    static let DE: String   = "de"
}

struct Categories{
    
    static let BUSINESS: String = "business"
    
}

enum APIError: Error{
    case failedToGetData
}

//struct APICaller{
class APICaller{
    
    var isPaginating    = false
    
//    static let shared = APICaller()
    
    func getNews(with pageNumber: Int, completion: @escaping (Result<[News], Error>) -> Void){
        
        self.isPaginating   = true
        
        let pageSize    = 5
        
        let baseUrl     = "\(Constants.BASE_URL)\(Constants.TOP_HEADLINE)"
        
        let codeUrl     = "\(Constants.COUNTRY)\(Countries.US)"
        
        let pageUrl     = "\(Constants.PAGE_SIZE)\(pageSize)\(Constants.PAGE)\(pageNumber)"
        
        let apiUrl      = "\(Constants.API_KEY)"
        
        let urlString   = baseUrl + codeUrl + pageUrl + apiUrl
        
        guard let url   = URL(string: urlString) else {return}
        
        let task            = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                
                let results     = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(results.articles))
                
            }catch{
                print(error)
                completion(.failure(error))
            }
            
        }
        task.resume()
        self.isPaginating   = false
    }
    
    func getFewNews(completion: @escaping (Result<[News], Error>) -> Void){
        
        let page        = 1
        let pageSize    = 5
        
        let baseUrl     = "\(Constants.BASE_URL)\(Constants.TOP_HEADLINE)"
        
        let codeUrl     = "\(Constants.COUNTRY)\(Countries.US)"
        
        let pageUrl     = "\(Constants.PAGE_SIZE)\(pageSize)\(Constants.PAGE)\(page)"
        
        let apiUrl      = "\(Constants.API_KEY)"
        
        let urlString   = baseUrl + codeUrl + pageUrl + apiUrl
        
        guard let url   = URL(string: urlString) else {return}
        
        let task            = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                
                let results     = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(results.articles))
                
            }catch{
                print(error)
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
    func getSomeNews(completion: @escaping (Result<[News], Error>) -> Void){
        
        let page        = 1
        let pageSize    = 20
        
        let baseUrl     = "\(Constants.BASE_URL)\(Constants.TOP_HEADLINE)"
        
        let codeUrl     = "\(Constants.COUNTRY)\(Countries.US)"
        
        let pageUrl     = "\(Constants.PAGE_SIZE)\(pageSize)\(Constants.PAGE)\(page)"
        
        let apiUrl      = "\(Constants.API_KEY)"
        
        let urlString   = baseUrl + codeUrl + pageUrl + apiUrl
        
        guard let url   = URL(string: urlString) else {return}
        
        let task            = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                
                let results     = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(results.articles))
                
            }catch{
                print(error)
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
    func search (with query: String, completion: @escaping (Result<[News], Error>) -> Void){
        
        let page        = 1
        let pageSize    = 20
        
        let baseUrl     = "\(Constants.BASE_URL)\(Constants.EVERYTHING)"
        
        let queryUrl    = "\(Constants.QUERY)"
        
        let pageUrl     = "\(Constants.PAGE_SIZE)\(pageSize)\(Constants.PAGE)\(page)"
        
        let apiUrl      = "\(Constants.API_KEY)"
        
        let urlStr      = baseUrl + queryUrl + query + pageUrl + apiUrl
        
        guard let url   = URL(string: urlStr) else {return}
        
        let task        = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {return}
            
            do{
                let results     = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(results.articles))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}

