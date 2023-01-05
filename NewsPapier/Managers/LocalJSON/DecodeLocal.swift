//
//  DecodeLocal.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/3/23.
//

import Foundation

#warning("That is to prevent \"429 Too Many Requests\" Error while development")
#warning("Decode from local while developing")

public struct DecodeLocal{
    
    static let shared = DecodeLocal()
    
    public init() {}
    
    func fetch<T: Decodable>(fileName: String) -> T? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let person = try? decoder.decode(T.self, from: data)
       else {
            return nil
       }

       return person
    }
    
}
