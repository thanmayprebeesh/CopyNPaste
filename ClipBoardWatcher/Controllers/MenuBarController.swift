//
//  MenuBarController.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import AppKit


final class MenuBarController {

    private let statusItem: NSStatusItem
    private let panelController: ClipboardPanelController

    init(panelController: ClipboardPanelController) {
        self.panelController = panelController

        statusItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength
        )

        statusItem.button?.image = NSImage(
            systemSymbolName: "doc.on.clipboard",
            accessibilityDescription: "Clipboard"
        )

        statusItem.button?.target = self
        statusItem.button?.action = #selector(togglePanel)
    }

    @objc private func togglePanel() {
        panelController.toggle()
    }
}

