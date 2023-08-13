//
//  ContentView.swift
//  ScilletAR
//
//  Created by Vladyslav Lysenko on 14.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
