//
//  RingUseCases.swift
//  Curv
//
//  Created by Euxcet on 2024/12/8.
//

public class RingUseCase {
    private let repository: RingRepository
    
    public init(repository: RingRepository) {
        self.repository = repository
    }
    
    public func scan() {
        repository.scan()
    }
}
