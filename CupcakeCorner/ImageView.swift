//
//  ImageView.swift
//  CupcakeCorner
//
//  Created by Om Preetham Bandi on 5/30/24.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There's an error")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ImageView()
}
