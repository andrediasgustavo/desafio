//
//  MockAPIService.swift
//  desafioTests
//
//  Created by Andre Dias on 16/07/23.
//

import Foundation
import Combine

@testable import desafio

final class MockMarvelAPIService: APIManagerInterface {
    func getData<T>(endpoint: desafio.Endpoint, type: T.Type) -> Future<T, Error> where T : Decodable, T : Encodable {
        <#code#>
    }

}
