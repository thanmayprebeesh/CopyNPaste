//
//  AppController.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import Foundation
import SwiftUI
import KeyboardShortcuts

final class AppController{
    private let panelController: ClipboardPanelController
    
    private let clipboardManager: ClipboardManager
    
    init(){
        self.clipboardManager = ClipboardManager()
        
        panelController = ClipboardPanelController(clipboardManager: clipboardManager)
        
        KeyboardShortcuts.onKeyUp(for: .toggleClipboardPanel) {
            self.panelController.toggle()
        }
    }
}
