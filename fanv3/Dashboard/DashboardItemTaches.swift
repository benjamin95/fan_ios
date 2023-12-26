//
//  DashboardItemTaches.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import SwiftUI

struct DashboardItemTaches: View {
    @StateObject var viewModel: TacheViewModel  = TacheViewModel()
    
    @State var nbr: String = "0"
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    HStack{
                        
                        viewModel.taches.count != 0 ? Text("\(viewModel.taches.count) Tâche en cours").foregroundColor(.white).fontWeight(.bold) : Text("Pas de tâches en cours").foregroundColor(Color.green)
                        Spacer()
                        Image(systemName: "list.bullet.clipboard.fill")
                            .foregroundColor(Color.blue)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(Color("Overlay"))
        .cornerRadius(15)
        .task{
            viewModel.getTachesNonFaites()
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Erreur"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct DashboardItemTaches_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemTaches()
    }
}
