//
//  ClipBoardPanelController.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import AppKit
import SwiftUI

final class ClipboardPanelController {

    private let clipboardManager: ClipboardManager
    private var panel: ClipboardPanel?

    init(clipboardManager: ClipboardManager) {
        self.clipboardManager = clipboardManager
    }

    func toggle() {
        panel?.isVisible == true ? hide() : show()
    }

    func show() {
        let panel = panel ?? createPanel()

        panel.center()

        NSApp.activate(ignoringOtherApps: true)
        panel.makeKeyAndOrderFront(nil)
    }

    func hide() {
        panel?.orderOut(nil)
    }

    private func createPanel() -> ClipboardPanel {
        let panel = ClipboardPanel(
            content: ClipboardView(
                clipboardManager: clipboardManager,
                panelController: self
            )
        )

        self.panel = panel
        return panel
    }
}
