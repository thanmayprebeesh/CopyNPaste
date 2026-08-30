//
//  PreferencesView.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 24/08/2026.
//

import SwiftUI
import ServiceManagement

import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let toggleClipboardPanel = Self("toggleClipboardPanel", initial: .init(.v, modifiers: [.command, .shift]))
}

struct PreferencesView: View {
    @AppStorage("launchAtLogin") private var launchAtLogin = false
    @AppStorage("closeOnCopyItem") private var closeOnCopyItem = true
    @AppStorage("showInDock") private var showInDock = false
    
    var body: some View {
        VStack{
            Toggle("Launch at login", isOn: $launchAtLogin)
                .onChange(of: launchAtLogin) { _, newValue in
                        do {
                            if newValue {
                                try SMAppService.mainApp.register()
                            } else {
                                try SMAppService.mainApp.unregister()
                            }
                        } catch {
                            print("Failed to \(newValue ? "register" : "unregister"): \(error)")
                        }
                    }
            
            Toggle("Close on copy item", isOn: $closeOnCopyItem)
            
            Divider()
            
            KeyboardShortcuts.Recorder("Open clipboard:", name: .toggleClipboardPanel)
        }
        .frame(width: 300, height: 150)
        .padding()
    }
}

#Preview {
    PreferencesView()
}
