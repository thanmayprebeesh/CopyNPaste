//
//  AppController.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import Foundation
import SwiftUI

final class AppController{
    private let panelController: ClipboardPanelController
    private let menubarController: MenuBarController
    
    private let hotKeyManager: HotKeyManager
    
    private let clipboardManager: ClipboardManager
    
    init(){
        self.clipboardManager = ClipboardManager()
        
        panelController = ClipboardPanelController(clipboardManager: clipboardManager)
        menubarController = MenuBarController(panelController: panelController)
        
        hotKeyManager = HotKeyManager()
        
        hotKeyManager.onHotKey = {[weak self] in
            self?.togglePanel()
        }
    }
    
    func togglePanel(){
        panelController.toggle()
    }
}
