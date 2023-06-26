//
//  LoadingImage.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

struct LoadingImage: View {
    var body: some View {
        
        // MARK: - first way
        
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        
        
        // MARK: - second way
        
        // bad url
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let img = phase.image {
                img
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                // placeholder
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadingImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImage()
    }
}
