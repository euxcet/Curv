//
//  MainViewModel.swift
//  Curv
//
//  Created by Euxcet on 2024/12/8.
//

import Foundation

public class MainViewModel: ObservableObject {
    private let ringUseCase: RingUseCase
    
    public init(ringUseCase: RingUseCase) {
        self.ringUseCase = ringUseCase
    }
    
    public func scanRing() {
        ringUseCase.scan()
    }
}
