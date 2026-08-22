//
//  ClipBoardWatcherApp.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 21/08/2026.
//

import SwiftUI

@main
struct ClipBoardWatcherApp: App {
    
    @State private var clipboardManager = ClipboardManager()
    
    var body: some Scene {
        MenuBarExtra("ClipBoardWatcher", systemImage: "doc.on.clipboard"){
            MenubarView(clipboardManager: clipboardManager)
        }
        .menuBarExtraStyle(.window)
    }
}
