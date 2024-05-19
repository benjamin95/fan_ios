//
//  InterventionDetailView.swift
//  fanv3
//
//  Created by Benjamin Truillet on 01/02/2024.
//

import SwiftUI

struct InterventionDetailView: View {
    
    var intervention : InterventionNom?
    
    var body: some View {
        Text((intervention?.date) ?? "2024-02-01")
        Text(convertIntToString(intervention?.technicien ?? 1)!)
        Text(intervention?.note ?? "PAs de note")
    }
}

#Preview {
    InterventionDetailView()
}
