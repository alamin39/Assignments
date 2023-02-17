//
//  ViewModel.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/15.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    @Published var repositoryList = [ItemInfo]()
    @Published var searchText = ""
    @Published var error: NetworkError?
    @Published var isLoading: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        isLoading = false
        error = nil
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map({ [weak self] text in
                guard text.count > 0 else {
                    self?.repositoryList = []
                    return nil
                }
                return text
            })
            .compactMap{ $0 }
            .sink { [weak self] res in
                self?.isLoading = false
                switch res {
                case .failure(let errorStr):
                    self?.error = NetworkError.custom(error: errorStr)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                self?.isLoading = true
                self?.error = nil
                self?.fetchData(searchText: value)
            }.store(in: &cancellable)
    }
    
    
    func fetchData(searchText: String?) {
        guard let searchText = searchText else { return }
        
        let urlString = "https://api.github.com/search/repositories?q=" + (searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { res in
                guard let response = res.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw NetworkError.serverError(statusCode: response.statusCode)
                }
                return res.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: RepositoryInfo.self, decoder: JSONDecoder())
            .sink { [weak self] res in
                self?.isLoading = false
                switch res {
                case .failure(let errorStr):
                    self?.error = errorStr as? NetworkError
                case .finished:
                    break
                }
            } receiveValue: { [weak self] repoList in
                self?.isLoading = false
                guard let items = repoList.items else { return }
                self?.repositoryList = items
            }.store(in: &cancellable)
    }
}
