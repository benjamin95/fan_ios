//
//  ClientListAFaire.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct ClientListAFaire: View {
    @StateObject var viewModel: ClientViewModel  = ClientViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var searchTerm = ""
    @State private var moisEnCours = ""
    
    var body: some View {
        NavigationStack{
            
            if viewModel.clients.isEmpty {
                
                ContentUnavailableView("Aucun client a faire", systemImage: "exclamationmark.triangle", description: Text("Pas de client trouvé"))
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
                
                .navigationTitle("Clients a finir")
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
                }
            }
            
           
            
        }
        .task {
            viewModel.getClientsAFaire()
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

struct ClientListAFaire_Previews: PreviewProvider {
    static var previews: some View {
        ClientListAFaire()
    }
}
