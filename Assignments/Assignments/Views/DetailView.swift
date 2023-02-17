//
//  DetailView.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/14.
//

import SwiftUI

struct DetailView: View {
    let url: URL?
    
    var body: some View {
        WebView(url: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: URL(string: "https://github.com"))
    }
}
