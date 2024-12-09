//
//  MainView.swift
//  Curv
//
//  Created by Euxcet on 2024/12/8.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.scanRing()
            }) {
                Text("Scan")
                    .font(.system(size: 14))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 88 / 255, green: 224 / 255, blue: 133 / 255))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
            }
        }
    }
}
