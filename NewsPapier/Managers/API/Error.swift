//
//  Error.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public enum ExternalAPIError: Error {
    case encoding
    case decoding
    case server(message: String)
}
