//
//  FavoriteFontsManager.swift
//  FontTypes
//
//  Created by Froylan Almeida on 11/17/25.
//

import Foundation
import Combine

class FavoriteFontsManager: ObservableObject {
    private let userDefaultsKey = "favoriteFonts"
    
    @Published var favoriteFonts: Set<String> = []
    
    init() {
        loadFavorites()
    }
    
    func addFavorite(_ fontName: String) {
        favoriteFonts.insert(fontName)
        saveFavorites()
    }
    
    func removeFavorite(_ fontName: String) {
        favoriteFonts.remove(fontName)
        saveFavorites()
    }
    
    func toggleFavorite(_ fontName: String) {
        if favoriteFonts.contains(fontName) {
            removeFavorite(fontName)
        } else {
            addFavorite(fontName)
        }
    }
    
    func isFavorite(_ fontName: String) -> Bool {
        return favoriteFonts.contains(fontName)
    }
    
    private func saveFavorites() {
        let array = Array(favoriteFonts)
        UserDefaults.standard.set(array, forKey: userDefaultsKey)
    }
    
    private func loadFavorites() {
        if let array = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            favoriteFonts = Set(array)
        }
    }
}

