//
//  ContentView.swift
//  project-two
//
//  Created by Paulinha Carlos on 17/10/23.
//

import SwiftUI
import Alamofire

struct GitHubUser: Decodable {
    let login: String
    let name: String?
    let htmlUrl: String?
    let location: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case htmlUrl = "html_url"
        case location
        case bio
    }
}

struct ContentView: View {
    @State private var data: String = "Carregando..."
    
    var body: some View {
        Text(data)
            .onAppear {
                // Aqui você pode usar Alamofire para fazer uma requisição GET usando responseDecodable
                AF.request("https://api.github.com/users/apaulinhacarlos").responseDecodable(of: GitHubUser.self) { response in
                    switch response.result {
                    case .success(let user):
                        print(user)
                        var userDetails = "Nome do Usuário: \(user.login)"
                        if let name = user.name {
                                   userDetails += "\nNome Completo: \(name)"
                               }
                        if let htmlUrl = user.htmlUrl {
                                   userDetails += "\nPerfil: \(htmlUrl)"
                               }
                        if let location = user.location {
                                   userDetails += "\nLocation: \(location)"
                               }
                        if let bio = user.bio {
                                   userDetails += "\nBio: \(bio)"
                               }
                        self.data = userDetails
                    case .failure(let error):
                        self.data = "Erro ao carregar dados: \(error.localizedDescription)"
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
