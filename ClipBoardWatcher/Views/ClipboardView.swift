//
//  MenubarView.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 22/08/2026.
//

import SwiftUI

struct ClipboardView: View {
    @AppStorage("closeOnCopyItem") private var closeOnCopyItem = true
    @AppStorage("playSoundOnCopyItem") private var playSoundOnCopyItem = true
    
    @State private var isCloseButtonHovered = false
    @State private var searchText: String = ""
    
    @FocusState private var isSearchFocused: Bool
    
    let clipboardManager: ClipboardManager
    let panelController: ClipboardPanelController?
    
    let shortcutKeys: [KeyEquivalent] = [
        "1", "2", "3", "4", "5",
        "6", "7", "8", "9"
    ]
    
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
                        .focused($isSearchFocused)
                    
                    //Hidden button to focus the search bar
                    Button{
                        isSearchFocused = true
                    } label:{
                        EmptyView()
                    }
                    .keyboardShortcut("f", modifiers: .command)
                    .hidden()
                }
                .padding(6)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.ultraThinMaterial)
                }
            }
            ScrollView{
                VStack{
                    ForEach(Array(filteredHistory.enumerated()), id: \.element.id) { index, item in
                        if index < 9{
                            Button {
                                clipboardManager.CopyItem(_item: item)
                                
                                if playSoundOnCopyItem{
                                    NSSound(named: "Bottle")?.play()
                                }
                                
                                if closeOnCopyItem {
                                    panelController?.toggle()
                                }
                            } label: {
                                ClipboardRow(
                                    item: item,
                                    shortcutNumber: index + 1
                                )
                            }
                            .buttonStyle(.plain)
                            .keyboardShortcut(
                                shortcutKeys[index],
                                modifiers: .command
                            )
                        }
                        else{
                            Button {
                                clipboardManager.CopyItem(_item: item)
                                
                                if closeOnCopyItem {
                                    panelController?.toggle()
                                }
                            } label: {
                                ClipboardRow(
                                    item: item,
                                    shortcutNumber: index + 1
                                )
                            }
                            .buttonStyle(.plain)
                        }
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
