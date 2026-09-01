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
    
    @State private var isHovered = false
    var shortcutNumber: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            switch item.content {
            case .text(let text):
                Text(text)
                    .foregroundStyle(.primary)
                    .font(.system(size: 12))
                    .lineLimit(10)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            case .image(let data):
                if let image = NSImage(data: data){
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                }
            }
            
            HStack(spacing: 3){
                Text("\(item.date.formatted(date: .abbreviated,time: .shortened))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("• From")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                if let bundleID = item.sourceApp,
                   let appURL = NSWorkspace.shared.urlForApplication(
                       withBundleIdentifier: bundleID
                   ) {
                    
                    let appName = FileManager.default
                        .displayName(atPath: appURL.path)
                    
                    Text(appName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                if shortcutNumber < 10 {
                    Text("⌘ " + String(shortcutNumber))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(10)
        .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isHovered ? .quaternary : .quinary)
                )
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .scaleEffect(isHovered ? 0.99 : 1)
        .pointingHandCursor()
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)){
                isHovered = hovering
            }
        }
    }
}

#Preview{
    ClipboardRow(item: .init(text: "Hello World", sourceApp: "com.apple.Safari"), shortcutNumber: 1)
}
