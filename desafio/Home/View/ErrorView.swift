//
//  ErrorView.swift
//  desafio
//
//  Created by Andre Dias on 16/07/23.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    var messageError: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.red)
                .padding()
            
            Text(Constants.errorViewTitle)
                .font(.title)
                .foregroundColor(.primary)
                .padding(.top, 16)
            
            Text(messageError)
                .font(.body)
                .foregroundColor(.primary)
                .padding(.bottom, 32)
            
            Button {
                viewModel.inputs.fetchMarvelComicsData()
            } label: {
                Text(Constants.errorViewBtntitle)
                    .font(.body)
                    .frame(minWidth: 250)
                    .frame(height: 50, alignment: .center)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewModel: HomeViewModel(apiService: MarvelAPIService(serviceManager: NetworkManager.shared)),
                  messageError: NetworkError.decodeError.localizedDescription)
    }
}
