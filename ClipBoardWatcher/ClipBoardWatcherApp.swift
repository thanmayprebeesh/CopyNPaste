//
//  ClipBoardWatcherApp.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 21/08/2026.
//

import SwiftUI

@main
struct ClipBoardWatcherApp: App {
    private var appController = AppController()
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some Scene {
        MenuBarExtra("MyApp", systemImage: "doc.on.clipboard") {
            Button("Open Settings") {
                openWindow(id: "settings")
            }
            .keyboardShortcut(",", modifiers: .command)
            
            Button("Quit") {
                NSApp.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: .command)
        }
        .menuBarExtraStyle(.menu) // default; shows a dropdown menu

        Window("Settings", id: "settings") {
            PreferencesView()
        }
        .windowResizability(.contentSize)
    }
}
