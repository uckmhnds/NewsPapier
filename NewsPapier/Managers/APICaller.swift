//
//  APICaller.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 30.09.2022.
//

import Foundation

public typealias ResultCompletion<Value> = (Result<Value, Error>) -> Void

public protocol ExternalAPIRequest: Encodable {
    
    associatedtype Response: Decodable
    var hostName: String { get }
    var resourceName: String { get }
    
}

public enum ExternalAPIError: Error {
    case encoding
    case decoding
    case server(message: String)
}

public class ExternalAPIClient{
    
    static let shared = ExternalAPIClient()
    
    init(){}
    
    // MARK: - Public
    
    public func fetch<T: ExternalAPIRequest>(_ request: T, completion: @escaping ResultCompletion<T.Response>) {
        
        guard let endpoint = self.endpoint(for: request) else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(ExternalAPIError.decoding))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    // MARK: - Private
    
    private func endpoint<T: ExternalAPIRequest>(for request: T) -> URL? {
        guard let url = URL(string: request.resourceName, relativeTo: URL(string: request.hostName)),
              var _ = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Bad url: \(request.hostName)/\(request.resourceName)")
        }
        return url
    }
    
}
