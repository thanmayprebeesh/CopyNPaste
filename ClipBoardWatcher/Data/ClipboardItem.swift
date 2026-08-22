//
//  ClipboardItem.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 21/08/2026.
//

import Foundation

enum ClipboardContent: Codable {
    case text(String)
    case image(Data)
}

struct ClipboardItem: Identifiable, Codable{
    let id: UUID
    let content: ClipboardContent
    let date: Date
    let sourceApp: String?
    
    init(text: String, sourceApp: String?) {
        self.id = UUID()
        self.content = .text(text)
        self.date = Date()
        self.sourceApp = sourceApp
    }
    
    init(image: Data, sourceApp: String?) {
        self.id = UUID()
        self.content = .image(image)
        self.date = Date()
        self.sourceApp = sourceApp
    }
}
