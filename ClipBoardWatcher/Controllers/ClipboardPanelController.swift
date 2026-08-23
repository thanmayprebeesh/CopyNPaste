//
//  ClipBoardPanelController.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import AppKit
import SwiftUI

final class ClipboardPanelController{
    private var panel: NSPanel?
    let clipboardManager: ClipboardManager
    
    init(clipboardManager: ClipboardManager){
        self.clipboardManager = clipboardManager
    }
    
    func toggle(){
        if let panel, panel.isVisible {
            hide()
        }
        else{
            show()
        }
    }
    
    func hide(){
        panel?.orderOut(nil)
    }
    
    func show(){
        if panel == nil {
            createPanel()
        }
        guard let panel else { return }
        
        positionPanel(panel)
        NSApp.activate()
        panel.orderFrontRegardless()   // shows it without activating your app or making it key
    }
    
    func createPanel(){
        let contentView = ClipboardView(clipboardManager: clipboardManager, panelController: self)
        
        let hostingView = NSHostingView(rootView: contentView)
        
        let panel = NSPanel(
            contentRect: NSRect(
                x: 0, y: 0, width: 320, height: 500
            ),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        
        panel.contentView = hostingView
        
        panel.isFloatingPanel = true
        panel.level = .floating
        
        panel.hidesOnDeactivate = false
        panel.becomesKeyOnlyIfNeeded = true
        
        panel.isMovableByWindowBackground = true
        
        panel.backgroundColor = .clear
        panel.isOpaque = false
        
        panel.hasShadow = true
        
        self.panel = panel
    }
    
    func positionPanel(_ panel: NSPanel){
        guard let screen = NSScreen.main else { return }
        
        let screenFrame = screen.visibleFrame
        
        let panelSize = panel.frame.size
        
        let x = screenFrame.midX - (panelSize.width / 2)
        let y = screenFrame.midY - (panelSize.height / 2)
        
        panel.setFrameOrigin(NSPoint(x: x, y: y))
    }
}
