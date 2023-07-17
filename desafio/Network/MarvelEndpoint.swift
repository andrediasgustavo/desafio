//
//  MarvelEndpoint.swift
//  desafio
//
//  Created by Andre Dias on 15/07/23.
//

import Foundation

enum MarvelEndpoint: Endpoint {
    case fetchMarvelComics
    
    var schema: String {
        switch self {
            default:
                return Constants.schema
        }
    }
    
    var baseURL: String {
        switch self {
            default:
                return try! Configuration.value(for: "BASE_URL")
        }
    }
    
    var path: String {
        switch self {
            case .fetchMarvelComics:
                return Constants.marvelComicsPath
        }
    }
    
    static var apiKey: String {
        return try! Configuration.value(for: "API_KEY")
    }
    
    static var timeStamp: String {
        return try! Configuration.value(for: "TIMESTAMP")
    }
    
    static var hashKey: String {
        return try! Configuration.value(for: "HASH_KEY")
    }
    
    var parameters: [URLQueryItem] {
        switch self {
            case .fetchMarvelComics:
            return [URLQueryItem(name: "apikey", value: MarvelEndpoint.apiKey),
                    URLQueryItem(name: "ts", value: MarvelEndpoint.timeStamp),
                    URLQueryItem(name: "hash", value: MarvelEndpoint.hashKey)]
        }
    }
    
    var method: String  {
        switch self {
            default:
                return Constants.method
        }
    }
}
