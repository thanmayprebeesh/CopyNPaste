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
    
    init(text: String) {
        self.id = UUID()
        self.content = .text(text)
        self.date = Date()
    }
    
    init(image: Data) {
        self.id = UUID()
        self.content = .image(image)
        self.date = Date()
    }
}
