//
//  InterventionAjoutView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct InterventionAjoutView: View {
    var client:Client
    
    @StateObject var viewModel = InterventionViewModel()
    
    @State private var date: Date = Date()
    @State private var note: String = "RAS"
    @State private var typeInterventionIndex = 1
    let typeInterventionOptions = [ "Mise en place", "Suivi", "Reprise"]
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Détails de l'intervention")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    TextEditor(text: $note).frame(height: 100)
                    Picker(selection: $typeInterventionIndex, label: Text("Type Intervention")) {
                        ForEach(0 ..< typeInterventionOptions.count, id: \.self) {
                            Text(self.typeInterventionOptions[$0])
                        }
                    }
                }
            }
            HStack{
                Button(action:
                        {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let formattedDate = dateFormatter.string(from: date)
                    let userId = JWT.shared.getUserId()
                    let intervention:Intervention = Intervention(date: formattedDate, note: note, typeIntervention: typeInterventionOptions[typeInterventionIndex], technicien: Int(userId!), client:  client.id, id: 1)
                    viewModel.ajoutIntervention(intervention: intervention)
                    self.isPresented = viewModel.isPresented
                    //print(intervention)
                    
                }
                ) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
            .buttonStyle(.bordered)
            
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Erreur"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Nouvelle intervention")
        }
        
    }
    
}

struct InterventionAjoutView_Previews: PreviewProvider {
    static var previews: some View {
        
        let intervention = Intervention(date: "TEst", note: "TEst", typeIntervention: "TEst", technicien: 3, client: 3, id: 1)
        
        let client = Client(
            id: 1,
            nom: "John Doe",
            adresse: "123 Main St",
            ville: "Springfield",
            codePostal: 12345,
            telFixe: "555-555-5555",
            telPortable: "555-555-5555",
            contact: "Jane Smith",
            derniereInter: "2023-08-17",
            statutMagasin: "Ouvert",
            prestation: "Nettoyage",
            delaiProchaineInter: 30,
            prochaineInter: "2023-09-17",
            lat: "37.7749",
            lng: "-122.4194",
            interventions: [intervention]
        )
        
        InterventionAjoutView(client: client, isPresented: .constant(true))
    }
}
