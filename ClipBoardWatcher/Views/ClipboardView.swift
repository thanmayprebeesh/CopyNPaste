//
//  MenubarView.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 22/08/2026.
//

import SwiftUI

struct ClipboardView: View {
    @State private var isCloseButtonHovered = false
    
    let clipboardManager: ClipboardManager
    let panelController: ClipboardPanelController?
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Button{
                    panelController?.toggle()
                } label: {
                    Image(systemName: "x.circle.fill")
                }
                .buttonStyle(.plain)
                .scaleEffect(isCloseButtonHovered ? 1.1 : 1)
                .pointingHandCursor()
                .onHover { hovering in
                    withAnimation(.easeInOut(duration: 0.15)){
                        isCloseButtonHovered = hovering
                    }
                }
                
                ClipboardSearchBar()
            }
            
            ScrollView{
                VStack{
                    ForEach(clipboardManager.history){ item in
                        Button{
                            clipboardManager.CopyItem(_item: item)
                        } label:{
                            ClipboardRow(item: item)
                        }
                        .buttonStyle(.plain)
                        
                        
                    }
                }
            }
            .scrollIndicators(.never)
            .frame(height: 500)
            
            HStack{
                Text("\(clipboardManager.history.count)/10")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Button{
                    clipboardManager.ClearHistory()
                } label:{
                    Text("Clear Clipboard")
                        .font(.default)
                    
                    Image(systemName: "document.on.trash")
                        .font(.default)
                }
                .pointingHandCursor()
            }
        }
        .frame(width: 320, height: 570)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    //Change this so that its not monitoring everytime its initialized
    ClipboardView(clipboardManager: ClipboardManager(), panelController: nil)
}
