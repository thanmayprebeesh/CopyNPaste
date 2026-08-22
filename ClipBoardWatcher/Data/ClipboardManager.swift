//
//  ClipboardManager.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 21/08/2026.
//

import AppKit
import Foundation

@Observable
class ClipboardManager{
    private let pasteboard = NSPasteboard.general
    private var lastChangeCount: Int = 0
    private var ignoreNextChange: Bool = false
    
    var history : [ClipboardItem] = []
    
    init(){
        loadHistory()
        
        lastChangeCount = pasteboard.changeCount
        
        Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: true,
        ) { _ in
            self.checkClipboard()
        }
    }
    
    private func checkClipboard(){
        if pasteboard.changeCount != lastChangeCount{
            lastChangeCount = pasteboard.changeCount
            
            if(ignoreNextChange) {
                ignoreNextChange = false
                return
            }
            
            AddToHistory()
        }
    }
    
    private func AddToHistory(){
        if let text = pasteboard.string(forType: .string) {
            history.insert(ClipboardItem(text: text), at: 0)
        }
        else if let image = pasteboard.data(forType: .tiff) {
            history.insert(ClipboardItem(image: image), at: 0)
        }
        
        if history.count > 10{
            history.removeLast()
        }
        
        saveHistory()
    }
    
    public func ClearHistory(){
        history.removeAll(keepingCapacity: false)
        saveHistory()
    }
    
    public func CopyItem(_item: ClipboardItem){
        ignoreNextChange = true
        NSPasteboard.general.clearContents()
        switch _item.content {
            case .text(let text):
                NSPasteboard.general.setString(text, forType: .string)
            case .image(let image):
                NSPasteboard.general.setData(image, forType: .tiff)
        }
        
        lastChangeCount = pasteboard.changeCount
    }
    
    private func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: "clipboardHistory")
        }
    }
    
    private func loadHistory(){
        guard let data = UserDefaults.standard.data(
                forKey: "clipboardHistory"
            ) else {
                return
            }
            
            if let savedHistory = try? JSONDecoder().decode(
                [ClipboardItem].self,
                from: data
            ) {
                history = savedHistory
            }
    }
}
