//
//  HomeViewModel.swift
//  desafio
//
//  Created by Andre Dias on 15/07/23.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject, HomeVMInterfaces {
    
    private var subscriptions = Set<AnyCancellable>()
    private var apiRequest: APIManagerInterface
    
    init(apiService: APIManagerInterface) {
        self.apiRequest = apiService
        self.isLoading = self.isLoadingProperty.eraseToAnyPublisher()
        self.comicsList = self.comicsListProperty.eraseToAnyPublisher()
        self.bottomLabelText = self.bottomLabelTextProperty.eraseToAnyPublisher()
        self.error = self.errorProperty.eraseToAnyPublisher()
    }
    
    public var inputs: HomeVMInput { return self }
    public var outputs: HomeVMOutput { return self }
    
    // MARK: Input Methods and Variables
    private var isLoadingProperty = CurrentValueSubject<Bool, Never>(false)
    private var errorProperty = PassthroughSubject<String, Never>()
    private var comicsListProperty = CurrentValueSubject<[ComicItem], Never>([])
    private var bottomLabelTextProperty = CurrentValueSubject<String, Never>("")
    
    func fetchMarvelComicsData() {
        self.isLoadingProperty.send(true)
        self.apiRequest.getData(endpoint: MarvelEndpoint.fetchMarvelComics, type: MarvelComicsResponse.self)
            .sink { completion in
              switch completion {
              case .failure(let err):
                  self.errorProperty.send(err.localizedDescription)
                  self.isLoadingProperty.send(false)
              case .finished:
                  self.isLoadingProperty.send(false)
              }
          }
          receiveValue: { [weak self] response in
              self?.bottomLabelTextProperty.send(response.attributionText)
              
              if let comicsList = self?.transformMarvelResponse(response: response), !comicsList.isEmpty {
                  self?.comicsListProperty.send(comicsList)
                  self?.isLoadingProperty.send(false)
              }
          }
          .store(in: &subscriptions)
    }
    
    private func transformMarvelResponse(response: MarvelComicsResponse) -> [ComicItem]? {
        return response.data.results.map { value -> ComicItem in
            return ComicItem(value)
        }
    }
    
    // MARK: Output Methods and Variables
    internal var error: AnyPublisher<String, Never>!
    internal var isLoading: AnyPublisher<Bool, Never>!
    internal var comicsList: AnyPublisher<[ComicItem], Never>!
    internal var bottomLabelText: AnyPublisher<String, Never>!
}
