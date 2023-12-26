//
//  TacheTabView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import SwiftUI

struct TacheTabView: View {
    @State private var selectedTab = 0
    @StateObject var viewModel: TacheViewModel  = TacheViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TacheNonFaiteView()
                .tabItem {
                    VStack {
                        Image(systemName: "checkmark.circle")
                        Text("A faire")
                        
                    }
                }
                .badge(viewModel.tachesNonFaites)
                .tag(0)
            
            TacheFaiteView()
                .tabItem {
                    VStack {
                        Image(systemName: "2.circle")
                        Text("Faites")
                        
                    }
                }
                .tag(1)
                .badge(viewModel.tachesFaites)
        }
        .task {
            viewModel.getTaches()
            viewModel.getTachesNonFaites()
        }
    }
}

struct TacheTabView_Previews: PreviewProvider {
    static var previews: some View {
        TacheTabView()
    }
}

struct TacheNonFaiteView: View {
    @StateObject var viewModel: TacheViewModel  = TacheViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            List {
                ForEach($viewModel.taches) { $tache in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(tache.client!.nom!)
                            Spacer()
                            tache.fait! ? Text("Fait le \(formatDateInFrench(dateString: tache.faitLe ?? "" ) ?? "Pas de date") ") : Text("")
                        }
                        Label {
                            Text(tache.tache!)
                        } icon: {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(tache.fait! ? .green : .red) // Remplacez .red par la couleur de votre choix
                        }
                    }
                    .swipeActions {
                        
                        Button(action: {
                            print("Action de balayage 2 pour la \(String(describing: tache.tache!))")
                            print(tache.client!.id)
                            viewModel.editTache(tache: tache)
                            
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "checkmark")
                        }
                        .tint(.green)
                    }
                }
            }
            .listStyle(.grouped)
        }
        .task {
            viewModel.getTachesNonFaites()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
        }
    }
}

struct TacheFaiteView: View {
    @StateObject var viewModel: TacheViewModel  = TacheViewModel()
    var body: some View {
        VStack {
            List {
                ForEach($viewModel.taches) { $tache in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(tache.client!.nom!)
                            Spacer()
                            tache.fait! ? Text("Fait le \(formatDateInFrench(dateString: tache.faitLe ?? "" ) ?? "Pas de date") ") : Text("")
                        }
                        Label {
                            Text(tache.tache!)
                        } icon: {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(tache.fait! ? .green : .red) // Remplacez .red par la couleur de votre choix
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .task {
            viewModel.getTaches()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Erreur"), message: Text(viewModel.errorMessage!), dismissButton: .default(Text("OK")))
        }
    }
}
