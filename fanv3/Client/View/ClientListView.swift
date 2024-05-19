//
//  ClientListView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 19/08/2023.
//

import SwiftUI

struct ClientListView: View {
    @StateObject var viewModel: ClientViewModel  = ClientViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationStack{
            
            if viewModel.clients.isEmpty {
                
                ContentUnavailableView("Pas de client dans la base", systemImage: "exclamationmark.triangle", description: Text("Aucun client trouvé"))
            }
            else {
                VStack {
                    List(filteredClients) { client in
                        VStack(alignment: .leading) {
                            NavigationLink {
                                ClientDetail2(client: client)
                            } label: {
                                Text(client.nom ?? "Inconnu")
                            }
                        }
                    }
                    .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Recherche Client")
                    .overlay {
                        if filteredClients.isEmpty{
                            ContentUnavailableView("Aucun client : \(searchTerm)", systemImage: "exclamationmark.triangle", description: Text("Aucun client trouvé"))
                        }
                        
                    }
                    .listStyle(.plain)
                }
                .task {
                    
                }
                
                .navigationTitle("Clients")
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
                }
            }
            
           
            
        }
        .task {
            viewModel.getClients()
        }
    }
    var filteredClients: [Client] {
        guard !searchTerm.isEmpty else { return viewModel.clients }
        return viewModel.clients.filter{
            ($0.nom?.localizedCaseInsensitiveContains(searchTerm) ?? false) ||
            ($0.adresse?.localizedCaseInsensitiveContains(searchTerm) ?? false)
        }
    }
    func printToken() {
        print(JWT.shared.getAccessToken()!)
    }
}

struct ClientListView_Previews: PreviewProvider {
    static var previews: some View {
        ClientListView()
    }
}
