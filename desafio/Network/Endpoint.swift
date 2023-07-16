//
//  Endpoint.swift
//  desafio
//
//  Created by Andre Dias on 15/07/23.
//

import Foundation

protocol Endpoint {
    
    // HTTP, HTTPS
    var schema: String { get }
    
    // Ex: "api.example.com"
    var baseURL: String { get }
    
    // "/services/rest/"
    var path: String { get }
    
    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] { get }
    
    // GET
    var method: String { get }
}

