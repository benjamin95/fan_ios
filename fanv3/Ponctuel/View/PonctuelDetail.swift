//
//  PonctuelDetail.swift
//  fanv3
//
//  Created by Benjamin Truillet on 28/12/2023.
//

import SwiftUI

struct PonctuelDetail: View {
    
    var ponctuel: Ponctuel
    @State var fait: Bool
   
    init(ponctuel: Ponctuel) {
        self.ponctuel = ponctuel
        self.fait = self.ponctuel.fait!
    }

    var body: some View {
        NavigationStack {
            VStack {
                CircleWithInitialsView(initials: "BT", circleColor: .blue)
                
                Spacer()
                
                Form {
                    Section(header: Text("Infos Client")) {
                        LabeledContent("Client", value: ponctuel.nom ?? "Inconnu")
                        LabeledContent("Adresse", value: ponctuel.adresse ?? "Inconnu")
                        LabeledContent("Telephone", value: ponctuel.telFixe ?? "Inconnu")
                    }
                    
                    Section(header: Text("Intervention")) {
                        LabeledContent("Contact", value: ponctuel.contact ?? "Inconnu")
                        LabeledContent("Date", value: formatDateInFrench(dateString: ponctuel.dateInter!) ?? "Inconnu")
                        LabeledContent("Heure", value: ponctuel.heureInter ?? "Inconnu")
                        LabeledContent("Note", value: ponctuel.note ?? "Inconnu")
                        Toggle("Fait", isOn: $fait)
                    }
                    Section {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Valider l'intervention")
                        })
                    }
                }
            }
        }
        .navigationTitle(ponctuel.nom ?? "Pas de nom lol")
    }
}

#Preview {
    PonctuelDetail(ponctuel: Ponctuel(id: 85, dateInter: "2023-12-26", nom: "Madame DURAND", adresse: "12 rue des beffes 72310 Paris", telFixe: "06 45 12 12 12", telPortable: nil, contact: "Corinne", heureInter: "13:15", fait: true, lat: "", lng: "", note: "Mettre en place piège à guêpes et ceci ou cel", technicien: 3))
}
