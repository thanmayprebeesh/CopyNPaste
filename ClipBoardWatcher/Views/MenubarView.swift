//
//  MenubarView.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 22/08/2026.
//

import SwiftUI

struct MenubarView: View {
    @State private var searchText: String = ""
    let clipboardManager: ClipboardManager
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Image(systemName: "doc.on.clipboard")
                    .font(.title2)
                
                Text("ClipSearch")
                    .font(.headline)
                
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
            .frame(width: 320)
            
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
                .frame(width: 320)
            }
            .scrollIndicators(.hidden)
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
            }
        }
        .padding()
    }
}

#Preview {
    MenubarView(clipboardManager: ClipboardManager())
}
