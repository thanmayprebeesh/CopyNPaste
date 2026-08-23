//
//  HotKeyManager.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import HotKey
import AppKit

final class HotKeyManager{
    private var hotKey: HotKey?
    
    var onHotKey: (() -> Void)?
    
    init(){
        hotKey = HotKey(key: .v, modifiers: [.command, .shift])
        
        hotKey?.keyDownHandler = { [weak self] in
            self?.onHotKey?()
        }
    }
}
