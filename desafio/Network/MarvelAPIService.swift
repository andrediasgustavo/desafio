//
//  MarvelAPIService.swift
//  desafio
//
//  Created by Andre Dias on 17/07/23.
//

import Foundation
import Combine

protocol MarvelAPIServiceInterface {
    func fetchMarvelComicsData() -> Future<MarvelComicsResponse, Error>
}

struct MarvelAPIService: MarvelAPIServiceInterface {
    
    let networkManager: NetworkManager
    
    init(serviceManager: NetworkManager) {
        networkManager = serviceManager
    }

    func fetchMarvelComicsData() -> Future<MarvelComicsResponse, Error> {
        return networkManager.getData(endpoint:  MarvelEndpoint.fetchMarvelComics, type: MarvelComicsResponse.self)
    }
}
