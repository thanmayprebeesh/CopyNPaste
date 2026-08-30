//
//  MenubarView.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 22/08/2026.
//

import SwiftUI

struct ClipboardView: View {
    @AppStorage("closeOnCopyItem") private var closeOnCopyItem = true
    
    @State private var isCloseButtonHovered = false
    @State private var searchText: String = ""
    
    let clipboardManager: ClipboardManager
    let panelController: ClipboardPanelController?
    
    var filteredHistory: [ClipboardItem] {
        clipboardManager.history.filter{ item in
            switch item.content{
            case .text(let text):
                return searchText.isEmpty || text.localizedCaseInsensitiveContains(searchText)
            case .image:
                return searchText.isEmpty
            }
        }
    }
    
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
                
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search Clipboard...", text: $searchText)
                        .textFieldStyle(.plain)
                    
                }
                .padding(6)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.ultraThinMaterial)
                }
            }
            ScrollView{
                VStack{
                    ForEach(filteredHistory){ item in
                        Button{
                            clipboardManager.CopyItem(_item: item)
                            if closeOnCopyItem{
                                panelController?.toggle()
                            }
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
