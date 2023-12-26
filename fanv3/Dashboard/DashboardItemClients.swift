//
//  DashboardItemClients.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct DashboardItemClients: View {
    
    @StateObject var viewModel: ClientViewModel  = ClientViewModel()
    
    @State var nbr: String = "0"
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    HStack{
                        Text("Clients")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "person.3.sequence.fill")
                            .foregroundColor(Color.green)
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
            viewModel.getClients()
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Erreur"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct DashboardItemClients_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemClients()
    }
}
