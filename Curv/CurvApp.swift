//
//  CurvApp.swift
//  Curv
//
//  Created by Euxcet on 2024/12/8.
//

import SwiftUI

@main
struct CurvApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RingRepositoryImpl()
            let ringUseCase = RingUseCase(repository: repository)
            let viewModel = MainViewModel(ringUseCase: ringUseCase)
            MainView(viewModel: viewModel)
        }
    }
}
