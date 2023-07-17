//
//  MockAPIService.swift
//  desafioTests
//
//  Created by Andre Dias on 16/07/23.
//

import Foundation
import Combine

@testable import desafio

struct MockMarvelAPIService: MarvelAPIServiceInterface {
    
    var shouldReturnErrorResponse: Bool
    
    init(returnErrorResponse: Bool = false) {
        shouldReturnErrorResponse = returnErrorResponse
    }

    func fetchMarvelComicsData() -> Future<MarvelComicsResponse, Error> {
        if shouldReturnErrorResponse {
            return returnErrorResponse()
        }
        return returnSuccessfulResponse()
    }

    private func setupMarvelAPIResponse() -> MarvelComicsResponse {
        var marvelComicsResult: [MarvelComicsResult] = []
        marvelComicsResult.append(MarvelComicsResult(id: 1308,
                                                     title: "Marvel Age Spider-Man Vol. 2: Everyday Hero (Digest)",
                                                     description: "\"The Marvel Age of Comics continues! This time around, Spidey meets his match against such classic villains as Electro and the Lizard, and faces the return of one of his first foes: the Vulture! Plus: Spider-Man vs. the Living Brain, Peter Parker\'s fight with Flash Thompson, and the wall-crawler tackles the high-flying Human Torch!\"",
                                                     thumbnail: MarvelComicsThumbnail(
                                                        path:"http://i.annihil.us/u/prod/marvel/i/mg/9/20/4bc665483c3aa",
                                                        thumbnailExtension: "jpg")))
        marvelComicsResult.append(MarvelComicsResult(id: 1003,
                                                     title: "Sentry, the (Trade Paperback)",
                                                     description: "",
                                                     thumbnail: MarvelComicsThumbnail(           path:"http://i.annihil.us/u/prod/marvel/i/mg/f/c0/4bc66d78f1bee",
                                                         thumbnailExtension: "jpg")))
        marvelComicsResult.append(MarvelComicsResult(id: 1003,
                                                     title: "Gun Theory (2003) #4",
                                                     description: "The phone rings, and killer-for-hire Harvey embarks on another hit. But nothing\'s going right this job. There\'s little room for error in the business of killing - so what happens when one occurs?\r\n32 PGS./ PARENTAL ADVISORY ...$2.50",
                                                     thumbnail: MarvelComicsThumbnail(           path:"http://i.annihil.us/u/prod/marvel/i/mg/c/60/4bc69f11baf75",
                                                         thumbnailExtension: "jpg")))
        return MarvelComicsResponse(attributionText: "Data provided by Marvel. © 2023 MARVEL", data: MarvelComicsData(results: marvelComicsResult))
    }
    
    private func returnSuccessfulResponse() -> Future<MarvelComicsResponse, Error> {
        return Future<MarvelComicsResponse, Error> { promise in
            promise(.success(self.setupMarvelAPIResponse()))
        }
    }
    
    private func returnErrorResponse() -> Future<MarvelComicsResponse, Error> {
        return Future<MarvelComicsResponse, Error> { promise in
            promise(.failure(NetworkError.decodeError))
        }
    }
}
