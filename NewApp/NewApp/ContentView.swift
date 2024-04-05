//
//  ContentView.swift
//  NewApp
//
//  Created by Lyndon Cruz on 4/3/24.
//

import SwiftUI
import POCTheme

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var systemColorScheme: ColorScheme
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State private var theme: POCTheme?

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Image("excursion/images/Landing_page_logo")
                .frame(width: 136.7, height: 80)
                .aspectRatio(contentMode: .fit)
            VStack {
                ZStack {
                    Text("welcome")
                        .font(.title)
                        .foregroundColor(isDarkMode ? Color(hex: theme?.darkOnPrimary ?? "FFFFFF") : Color(hex: theme?.lightOnPrimary ?? "000000"))
                        .offset(y: 20)
                }

                ZStack {
                    Text("aboard")
                        .font(.title)
                        .foregroundColor(isDarkMode ? Color(hex: theme?.darkOnPrimary ?? "FFFFFF") : Color(hex: theme?.lightOnPrimary ?? "000000"))
                        .transition(.move(edge: .bottom))
                        .offset(y: 10)
                }
                .transition(.scale)
            }
            .offset(y: 20)

            Button(action: {
                isDarkMode.toggle()
            }) {
                Text("Switch Mode")
                    .foregroundColor(isDarkMode ? Color(hex: theme?.darkOnPrimary ?? "FFFFFF") : Color(hex: theme?.lightOnPrimary ?? "000000"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: isDarkMode ? theme?.darkPrimary ?? "000000" : theme?.lightPrimary ?? "FFFFFF"))
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear(perform: fetchTheme)
    }

    func fetchTheme() {
        themeManager.fetchTheme { result in
            switch result {
            case .success(let fetchedTheme):
                DispatchQueue.main.async {
                    self.theme = fetchedTheme
//                    print("System color scheme: \(self.systemColorScheme)")
//                    self.isDarkMode = self.systemColorScheme == .dark
//                    print("isDarkMode: \(self.isDarkMode)")
                }
            case .failure(let error):
                print("Failed to fetch theme: \(error.localizedDescription)")
            }
        }
    }
}

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

