//
//  ClipboardRow.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 21/08/2026.
//

import SwiftUI
import AppKit

struct ClipboardRow: View{
    let item: ClipboardItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2){
            switch item.content {
            case .text(let text):
                Text(text)
                    .foregroundStyle(.primary)
                    .font(.system(size: 12))
                    .lineLimit(10)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(item.date.formatted(date: .abbreviated,time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            case .image(let data):
                if let image = NSImage(data: data){
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                }
            }
            
            
        }
        .padding(10)
        .background(.quaternary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
}
