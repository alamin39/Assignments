//
//  HomeView.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/14.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showErrorAlert = false
    @State private var error: NetworkError?
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.searchText.isEmpty {
                    Text("Type something to search")
                        .padding()
                }
                else if viewModel.isLoading {
                    ProgressView("Processing")
                }
                else if viewModel.repositoryList.isEmpty {
                    Text("No search result found!")
                        .padding()
                }
                else {
                    List {
                        ForEach(viewModel.repositoryList, id: \.fullName) { gitRepo in
                            let url = URL(string: gitRepo.htmlURL ?? "")!
                            Link(destination: url) {
                                Text(gitRepo.fullName ?? "")
                            }
                            .padding(12)
                        }
                    }
                }
            }
            .navigationTitle("Github Repositories")
            .font(.headline)
            .searchable(text: $viewModel.searchText, prompt: "Search Repository")
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text(error?.title ?? ""),
                    message: Text(error?.message ?? ""),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .onReceive(viewModel.$error) { networkError in
                error = networkError
                showErrorAlert = (error != nil)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: ViewModel())
    }
}
