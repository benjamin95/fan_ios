//
//  CercleInitial.swift
//  fanv3
//
//  Created by Benjamin Truillet on 28/12/2023.
//

import Foundation
import SwiftUI

struct CircleWithInitialsView: View {
    let initials: String
    let circleColor: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: 100, height: 100) // Ajustez la taille du cercle selon vos besoins

            Text(initials)
                .font(.system(size: 50))
                .foregroundColor(.white)
        }
    }
}
