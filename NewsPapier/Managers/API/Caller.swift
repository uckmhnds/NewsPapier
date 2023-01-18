//
//  Caller.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

public class ExternalAPIClient{
    
    static let shared = ExternalAPIClient()
    
    init(){}
    
    // MARK: - Public
    
    public func fetch<T: ExternalAPIRequest>(_ request: T, completion: @escaping ResultCompletion<T.Response>) {
        
        var urlRequest: URLRequest?
        
//        guard let endpoint = self.endpoint(for: request) else { return }
        
        if let request = request as? FinanceRequest
        {
            urlRequest = request.request()
        }
        else if let endpoint = self.endpoint(for: request)
        {
            urlRequest = URLRequest(url: endpoint)
        }
        else
        {
            return
        }
        
        if let urlRequest = urlRequest{
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
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
    }
    
    
    public func fetchParallel(){}
    
    // MARK: - Private
    
    private func endpoint<T: ExternalAPIRequest>(for request: T) -> URL? {
        guard let url = URL(string: request.resourceName, relativeTo: URL(string: request.hostName)),
              var _ = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Bad url: \(request.hostName)/\(request.resourceName)")
        }
        return url
    }
    
}
