//
//  ClipboardPanel.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import AppKit
import SwiftUI

final class ClipboardPanel: NSPanel {

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
    
    //Function to hide panel on pressing the ESC key
    override func cancelOperation(_ sender: Any?) {
        orderOut(nil)
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
