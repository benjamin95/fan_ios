//
//  InterventionAjoutView.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 20/08/2023.
//

import SwiftUI

struct InterventionAjoutView: View {
    
    func sendImageToAPI() {
        
       
        
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.1) else {
                print("Failed to convert image to data")
                return
            }
            
            // Créez votre URL d'API ici
        guard let url = URL(string: "\(getAPiUrl())images/") else {
            
            print("URL invalide")
            return
        }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(JWT.shared.getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let body = NSMutableData()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"client\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(self.client.id )\r\n".data(using: .utf8)!)
            
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"fichier\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            
            // Convertir la chaîne en données binaires
            if let stringData = "--\(boundary)\r\nContent-Disposition: form-data; name=\"fichier\"; filename=\"image.jpg\"\r\nContent-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                body.append(stringData)
            } else {
                print("Failed to convert string to data")
                return
            }
            
            // Ajoutez les données binaires de l'image
            body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
            
            // Ajoutez la clôture de la requête multipart
            if let stringData = "--\(boundary)--\r\n".data(using: .utf8) {
                body.append(stringData)
            } else {
                print("Failed to convert string to data")
                return
            }
            
            request.httpBody = body as Data
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Gérer la réponse de l'API
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    // Traiter la réponse de l'API (si nécessaire)
                   print("Response: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }.resume()
        }
    
    
    var client:Client
    
    @StateObject var viewModel = InterventionViewModel()
    
    @State private var date: Date = Date()
    @State private var note: String = "RAS"
    @State private var typeInterventionIndex = 1
    let typeInterventionOptions = [ "Mise en place", "Suivi", "Reprise"]
    
    
    @State private var selectedImage: UIImage?
    @State private var showCamera = false
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Détails de l'intervention")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                    TextEditor(text: $note).frame(height: 100)
                    Picker(selection: $typeInterventionIndex, label: Text("Type Intervention")) {
                        ForEach(0 ..< typeInterventionOptions.count, id: \.self) {
                            Text(self.typeInterventionOptions[$0])
                        }
                    }
                    HStack {
                                if let selectedImage{
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFit()
                                }
                                
                                Button("Ajouter le bon d'intervention") {
                                    self.showCamera.toggle()
                                }.buttonStyle(.bordered)
                                .fullScreenCover(isPresented: self.$showCamera) {
                                    accessCameraView(selectedImage: self.$selectedImage)
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
                    sendImageToAPI()
                    
                }
                ) {
                    HStack {
                        Spacer()
                        Text("Valider l'intervention")
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            
            
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Succés"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
