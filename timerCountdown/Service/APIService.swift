//
//  APIService.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import Foundation
import Combine

class APIService {
    // Simulate API to fetch remaining duration
    func fetchRemainingDuration() -> AnyPublisher<Int, Never> {
        // Simulate 10 seconds duration from backend (in milliseconds)
        let durationMilliseconds = 10_000
        return Just(durationMilliseconds).eraseToAnyPublisher()
    }

    // Simulate API validation on button press
    func validateButtonAction() -> AnyPublisher<Bool, Error> {
        // Simulate success after 1s delay
        return Just(true)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
