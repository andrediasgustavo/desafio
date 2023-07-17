//
//  HomeViewModelInterface.swift
//  desafio
//
//  Created by Andre Dias on 16/07/23.
//

import Foundation
import Combine

protocol HomeVMInput {
    func fetchMarvelComicsData()
}

protocol HomeVMOutput {
    var error: AnyPublisher<String?, Never>! { get }
    var isLoading: AnyPublisher<Bool, Never>! { get }
    var comicsList: AnyPublisher<[ComicItem], Never>! { get }
    var bottomLabelText: AnyPublisher<String, Never>! { get }
}

protocol HomeVMInterfaces: HomeVMInput, HomeVMOutput {
    var inputs: HomeVMInput { get }
    var outputs: HomeVMOutput { get }
}
