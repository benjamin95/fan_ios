//
//  DashboardTabView.swift
//  fanv3
//
//  Created by Benjamin Truillet on 06/01/2024.
//

import SwiftUI

struct DashboardTabView: View {
    var body: some View {
        TabView {
            ClientListView()
                .badge(103)
                .tabItem {
                    Label("Clients", systemImage: "tray.and.arrow.down.fill")
                }
            ClientListRetard()
                .badge(93)
                .tabItem {
                    Label("Retards", systemImage: "tray.and.arrow.up.fill")
                }
            ClientListAFaire()
                .badge("4")
                .tabItem {
                    Label("Ce mois", systemImage: "person.crop.circle.fill")
                }
            TacheListView()
                .badge("4")
                .tabItem {
                    Label("Tâches", systemImage: "list.bullet")
                }
            PonctuelListView()
                .badge("4")
                .tabItem {
                    Label("Ponctuels", systemImage: "calendar.badge.checkmark")
                }
            
        }
    }
}

#Preview {
    DashboardTabView()
}
