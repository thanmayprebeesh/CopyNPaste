//
//  ClipboardPanel.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import AppKit
import SwiftUI

//To relay data from ClipboardPanel to ClipboardView
extension Notification.Name {
    static let clipboardMoveUp = Notification.Name("clipboardMoveUp")
    static let clipboardMoveDown = Notification.Name("clipboardMoveDown")
    static let clipboardSelect = Notification.Name("clipboardSelect")
}

final class ClipboardPanel: NSPanel {

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
    
    //Function to hide panel on pressing the ESC key
    override func cancelOperation(_ sender: Any?) {
        orderOut(nil)
    }
    
    //Function to use arrow keys to navigate clipboard
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 126: // Up arrow
            NotificationCenter.default.post(
                name: .clipboardMoveUp,
                object: nil
            )

        case 125: // Down arrow
            NotificationCenter.default.post(
                name: .clipboardMoveDown,
                object: nil
            )
            
        case 36: // Return
            NotificationCenter.default.post(
                name: .clipboardSelect,
                object: nil
            )

        default:
            super.keyDown(with: event)
        }
    }

    convenience init<Content: View>(content: Content) {
        self.init(
            contentRect: .init(
                x: 0,
                y: 0,
                width: 320,
                height: 570
            ),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        contentView = NSHostingView(rootView: content)

        isFloatingPanel = true
        level = .floating
        hidesOnDeactivate = false
        isMovableByWindowBackground = true

        backgroundColor = .clear
        isOpaque = false
        hasShadow = true
    }
}
