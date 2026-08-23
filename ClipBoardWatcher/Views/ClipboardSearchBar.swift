//
//  ClipboardSearchBar.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import SwiftUI

struct ClipboardSearchBar: View{
    @State private var searchText: String = ""
    
    var body: some View{
        HStack {
          Image(systemName: "magnifyingglass")
          TextField("Search Clipboard...", text: $searchText)
                
        }
        .padding(6)
        .background {
           RoundedRectangle(cornerRadius: 10)
             .foregroundStyle(.ultraThinMaterial)
        }
    }
}

#Preview {
    ClipboardSearchBar()
}
