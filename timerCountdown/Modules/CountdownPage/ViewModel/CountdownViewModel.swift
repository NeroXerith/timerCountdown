//
//  CountdownViewModel.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import Foundation
import Combine

class CountdownViewModel: ObservableObject {
    @Published var timeRemaining: String = "00:00:00"
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        let timer = Timer.publish(every: 1, on: .main, in: .init(seconds: 0, nanoseconds: 0))
    }
}
