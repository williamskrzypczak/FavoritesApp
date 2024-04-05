//
//  ContentView.swift
//  FavoritesApp
//
//  Created by Bill Skrzypczak on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [Item] = [
        Item(name: "Item 1", isFavorite: false),
        Item(name: "Item 2", isFavorite: true),
        Item(name: "Item 3", isFavorite: false),
        Item(name: "Item 4", isFavorite: true),
        Item(name: "Item 5", isFavorite: false)
    ]
    
    @State private var showingFavoritesOnly = false

    // This computed property filters items based on showingFavoritesOnly
    var filteredItems: [Item] {
        showingFavoritesOnly ? items.filter { $0.isFavorite } : items
    }

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showingFavoritesOnly) {
                    Text("Show Favorites Only")
                }
                
                ForEach(filteredItems.indices, id: \.self) { index in
                    // As we're operating on filteredItems, we need a reliable way to reference back to the original items array
                    // Find the corresponding index in the original 'items' array
                    if let originalIndex = items.firstIndex(where: { $0.id == filteredItems[index].id }) {
                        HStack {
                            Text(filteredItems[index].name)
                            Spacer()
                            if filteredItems[index].isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                withAnimation {
                                    items[originalIndex].isFavorite = true
                                }
                            } label: {
                                Label("Favorite", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                withAnimation {
                                    items[originalIndex].isFavorite = false
                                }
                            } label: {
                                Label("Unfavorite", systemImage: "star.slash.fill")
                            }
                            .tint(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Items")
        }
    }
}

struct Item: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var isFavorite: Bool
}



#Preview {
    ContentView()
}
