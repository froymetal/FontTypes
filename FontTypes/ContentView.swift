//
//  ContentView.swift
//  FontTypes
//
//  Created by Froylan Almeida on 11/17/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let sampleText = "The quick brown fox jumps over the lazy dog."
    let allFonts: [String] = {
        var fonts: [String] = []
        for family in UIFont.familyNames.sorted() {
            for fontName in UIFont.fontNames(forFamilyName: family) {
                fonts.append(fontName)
            }
        }
        return fonts.sorted()
    }()
    
    @StateObject private var favoriteFontsManager = FavoriteFontsManager()
    @State private var fontSize: CGFloat = 16
    
    var sortedFonts: [String] {
        allFonts.sorted { font1, font2 in
            let isFavorite1 = favoriteFontsManager.isFavorite(font1)
            let isFavorite2 = favoriteFontsManager.isFavorite(font2)
            
            if isFavorite1 && !isFavorite2 {
                return true
            } else if !isFavorite1 && isFavorite2 {
                return false
            } else {
                return font1 < font2
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(sortedFonts, id: \.self) { fontName in
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(fontName)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(sampleText.uppercased())
                                    .font(.custom(fontName, size: fontSize))
                                    .foregroundColor(.secondary)
                                
                                Text(sampleText)
                                    .font(.custom(fontName, size: fontSize))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                favoriteFontsManager.toggleFavorite(fontName)
                            }) {
                                Image(systemName: favoriteFontsManager.isFavorite(fontName) ? "star.fill" : "star")
                                    .foregroundColor(favoriteFontsManager.isFavorite(fontName) ? .yellow : .gray)
                                    .font(.title3)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                }
                .padding()
                .padding(.bottom, 100)
            }
            .navigationTitle("Tipos de Fuentes iOS")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    HStack {
                        Text("Tamaño de fuente")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(Int(fontSize))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(minWidth: 30)
                    }
                    .padding(.horizontal)
                    
                    Slider(value: $fontSize, in: 10...40, step: 1)
                        .padding(.horizontal)
                }
                .padding(.vertical, 12)
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
            }
        }
    }
}

#Preview {
    ContentView()
}
