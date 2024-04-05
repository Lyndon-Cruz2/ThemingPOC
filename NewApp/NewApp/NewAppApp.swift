//
//  NewAppApp.swift
//  NewApp
//
//  Created by Lyndon Cruz on 4/3/24.
//

import SwiftUI
import POCTheme

@main
struct NewAppApp: App {
    let themeManager = ThemeManager.shared

        var body: some Scene {
            WindowGroup {
                ContentView().environmentObject(themeManager)
            }
        }
}
