//
//  NetworkManager.swift
//  desafio
//
//  Created by Andre Dias on 15/07/23.
//

import Foundation
import Combine

protocol APIManagerInterface {
    func getData<T: Codable>(endpoint: Endpoint, type: T.Type) -> Future<T, Error>
}

class NetworkManager: APIManagerInterface {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Codable>(endpoint: Endpoint, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(NetworkError.unexpected))
                return
            }
            var urlComponents = URLComponents()
            urlComponents.scheme = endpoint.schema
            urlComponents.host = endpoint.baseURL
            urlComponents.path = endpoint.path
            urlComponents.queryItems = endpoint.parameters
            
            guard let url = urlComponents.url else {
                promise(.failure(NetworkError.invalidURL))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.method
            
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.unexpected
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let _ as DecodingError:
                            promise(.failure(NetworkError.decodeError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unexpected))
                        }
                    }
                }, receiveValue: { result in
                    promise(.success(result))
                })
                .store(in: &self.cancellables)
        }
    }
}



enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case decodeError
    case unexpected
                
    public var description: String {
        switch self {
        case .invalidURL:
            return Constants.invalidURL
        case .decodeError:
            return Constants.decodeError
        case .unexpected:
            return Constants.unexpectedError
        }
    }
}
