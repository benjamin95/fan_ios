//
//  DashboardItemAFaire.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct DashboardItemAFaire: View {
    
    @StateObject var viewModel: ClientViewModel  = ClientViewModel()
    
    @State var nbr: String = "0"
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var moisEnCours = ""
    
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    HStack{
                        Text("A faire pour \(moisEnCours)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "doc.badge.clock.fill")
                            .foregroundColor(Color.white)
                            .font(.title)
                    }
                    
                    Text(String(viewModel.clients.count))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(Color("Overlay"))
        .cornerRadius(15)
        .task{
            viewModel.getClientsAFaire()
            let currentDate = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM YYYY"
            dateFormatter.locale = Locale(identifier: "fr_FR")
            moisEnCours = dateFormatter.string(from: currentDate)
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Erreur"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct DashboardItemAFaire_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemAFaire()
    }
}
