//
//  ClientDetail2.swift
//  fanv3
//
//  Created by Benjamin Truillet on 07/01/2024.
//

import SwiftUI
import MapKit


struct ClientDetail2: View {
    
    var client: Client
    @State private var isSheetPresented = false
    @State private var alertMessage = ""

    func getRegion(coord: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: coord,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Map(initialPosition: .region(getRegion(coord: CLLocationCoordinate2D(latitude: convertStringToDouble(client.lat!)!, longitude: convertStringToDouble(client.lng!)!)))) {
                    Marker(client.nom!, coordinate: CLLocationCoordinate2D(latitude: convertStringToDouble(client.lat!)!, longitude: convertStringToDouble(client.lng!)!))
                    
                }
                
                
                Form {
                    Section(header: Text("Infos Client")) {
                        LabeledContent("Client", value: client.nom ?? "Inconnu")
                        LabeledContent("Adresse", value: client.adresse ?? "Inconnu")
                        LabeledContent("Telephone", value: client.telFixe ?? "Inconnu")
                        //LabeledContent("Statut", value: client.statutMagasin ?? "Inconnu")
                        //LabeledContent("Prestation", value: client.prestation ?? "Inconnu")
                        LabeledContent("Délai", value: String(client.delaiProchaineInter! ) )
                    
                        LabeledContent("Contact", value: client.contact ?? "Inconnu")
                        LabeledContent("Dérniére intervention", value: formatDateInFrench(dateString: (client.derniereInter)!) ?? "Inconnu")
                        LabeledContent("Prochaine intervention", value: formatDateInFrench(dateString: (client.prochaineInter) ?? "2024") ?? "Fin de contrat")
                    }
                    
                }
                
                
            }
            HStack(spacing:24) {
                
                
                Button {
                    openInWaze(latitude: convertStringToDouble(client.lat!)!, longitude: convertStringToDouble(client.lng!)!)
                } label: {
                    Text("Ouvrir dans Waze")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 170, height: 48)
                        .background(.blue)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    callClient(phoneNumber: client.telFixe!)
                        }) {
                            HStack {
                                Image(systemName: "phone.fill") // Icône de téléphone
                                    .foregroundColor(.white) // Couleur de l'icône

                                Text("Appeler le client")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .frame(width: 170, height: 48)
                            .background(Color.green)
                            .cornerRadius(12)
                        }
                    

            }
            .padding()
        }
        .navigationTitle(client.nom ?? "Pas de nom")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                
                    Button(action: {isSheetPresented = true}, label: {
                        Label("Home", systemImage: "folder.badge.plus").foregroundColor(Color.primary)
                        
                    })
                    .sheet(isPresented: $isSheetPresented) {
                        InterventionAjoutView(client: client, isPresented: $isSheetPresented)
                        
                    }
                    
                
            }
        }
    }
}



#Preview {
    
    ClientDetail2(client: Client(
        id: 574,
            nom: "A2PAS CHEVREAU 20EME",
            adresse: "40 Rue Henri Chevreau, 75020 Paris, France",
            ville: "Paris",
            codePostal: 75020,
            telFixe: "01 43 66 72 50",
            telPortable: nil, // Vous pouvez laisser nil si le numéro de portable est null
            contact: "Mr COGEZ",
            derniereInter: "2023-08-14",
            statutMagasin: "Régulé",
            prestation: "RT + DS Blattes",
            delaiProchaineInter: 90,
            prochaineInter: "2023-11-14",
            lat: "48.8705651",
            lng: "2.3886057",
            interventions: [Intervention(date: "TEst", note: "TEst", typeIntervention: "TEst", technicien: 3, client: 1, id: 1)]
            ))
}
