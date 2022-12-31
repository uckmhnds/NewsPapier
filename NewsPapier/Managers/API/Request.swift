//
//  Request.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public protocol ExternalAPIRequest: Encodable {
    
    associatedtype Response: Decodable
    var hostName: String { get }
    var resourceName: String { get }
    
}
