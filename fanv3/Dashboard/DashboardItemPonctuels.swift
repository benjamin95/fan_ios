//
//  DashboardItemPonctuels.swift
//  fanv3
//
//  Created by Benjamin Truillet on 28/12/2023.
//

import SwiftUI

struct DashboardItemPonctuels: View {
    @StateObject var viewModel: PonctuelViewModel  = PonctuelViewModel()
    
    @State var nbr: String = "0"
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    HStack{
                        
                        viewModel.ponctuels.count != 0 ? Text("\(viewModel.ponctuels.count) Hors contrat en cours").foregroundColor(.white).fontWeight(.bold) : Text("Pas de hors contrat en cours").foregroundColor(Color.green)
                        Spacer()
                        Image(systemName: "list.bullet.clipboard.fill")
                            .foregroundColor(Color.green)
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

#Preview {
    DashboardItemPonctuels()
}
