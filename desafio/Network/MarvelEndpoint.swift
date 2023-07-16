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
                return Constants.baseURL
        }
    }
    
    var path: String {
        switch self {
            case .fetchMarvelComics:
                return Constants.marvelComicsPath
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "b7e14bab409c70a5c4e7c2b319c09d7b"
        
        switch self {
            case .fetchMarvelComics:
            return [URLQueryItem(name: "apikey", value: apiKey),
                    URLQueryItem(name: "ts", value: "1682982412"),
                    URLQueryItem(name: "hash", value: "3482f01e9bf207a437a4b621c91339ad")]
        }
    }
    
    var method: String  {
        switch self {
            default:
                return Constants.method
        }
    }
    
    
}

