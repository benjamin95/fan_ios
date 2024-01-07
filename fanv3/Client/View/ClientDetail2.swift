//
//  ClientDetail2.swift
//  fanv3
//
//  Created by Benjamin Truillet on 07/01/2024.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
  //static let towerBridge = CLLocationCoordinate2D(latitude: 51.5055, longitude: -0.075406)
  static let boe = CLLocationCoordinate2D(latitude: 51.5142, longitude: -0.0885)
  static let hydepark = CLLocationCoordinate2D(latitude: 51.508611, longitude: -0.163611)
  static let kingsCross = CLLocationCoordinate2D(latitude: 51.5309, longitude: -0.1233)
}

func convertStringToDouble(_ inputString: String) -> Double? {
    // Utilisez la fonction Double() pour tenter de convertir la chaîne en Double
    if let convertedValue = Double(inputString) {
        return convertedValue
    } else {
        // La conversion a échoué, retourne nil (optionnel)
        return nil
    }
}

func getRegion(coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
    return MKCoordinateRegion(
        center: coordinate, // Coordonnées de la Tour Eiffel
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Ajustez ces valeurs pour le niveau de zoom
    )
}

struct ClientDetail2: View {
    
    var client: Client
    @State private var isSheetPresented = false
    @State private var mapCamPos: MapCameraPosition = .automatic
//    @State private var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 48.8588443, longitude: 2.2943506), // Coordonnées de la Tour Eiffel
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Ajustez ces valeurs pour le niveau de zoom
//        )
    
    private var region: MKCoordinateRegion {
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
    
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
                        LabeledContent("Prochaine intervention", value: formatDateInFrench(dateString: (client.prochaineInter)!) ?? "Inconnu")
                    }
                    
                }
                
                
            }
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
            interventions: [Intervention(date: "TEst", note: "TEst", typeIntervention: "TEst", technicien: 3, client: 3, id: 1)]
            ))
}
