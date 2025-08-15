//
//  CountdownViewModel.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import Foundation
import Combine

class CountdownViewModel: ObservableObject {
    
    // MARK: Inputs
    @Published var service: APIService!
    @Published var timer: AnyCancellable?
    @Published var durationInMilliSeconds: Int = 0
    
    // MARK: Outputs
    @Published var timeRemainingText: String = ""
    @Published var isButtonEabled: Bool = false
    @Published var showValidationSuccess: Bool = false
    @Published var showValidationFailure: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: APIService){
        self.service = service
    }
    
    func fetchInitialDuration() {
        service.fetchRemainingDuration()
            .sink { [weak self] millis in
                self?.startCountdown(from: millis)
            }
            .store(in: &cancellables)
    }
    
    func startCountdown(from millis: Int){
        durationInMilliSeconds = millis
        isButtonEabled = millis <= 0 ? false : true
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.durationInMilliSeconds -= 1000
                
                if self.durationInMilliSeconds <= 0 {
                    isButtonEabled = true
                    self.timeRemainingText = "You may proceed"
                    self.invalidateTimer()
                } else {
                    self.timeRemainingText = self.formatDuration(self.durationInMilliSeconds)
                }
            }
    }
    
    func formatDuration(_ duration: Int) -> String {
        let seconds = duration / 1000
        let minutes = seconds / 60
        let hours = minutes / 60
        let remainingSeconds = seconds % 60
        let remainingMinutes = minutes % 60
        
        return String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
    }
    
    func invalidateTimer() {
        self.timer?.cancel()
        timer = nil
    }
    
    /// Calls the API to re-fetch the remaining milliseconds from the server, ensuring server-side time accuracy to prevent client-server discrepancies and reduce security vulnerabilities.
    func validateButtonAction() {
        service.validateButtonAction()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.showValidationFailure = true
                }
            }, receiveValue: {[weak self] success in
                self?.showValidationSuccess = true })
            .store(in: &cancellables)
    }
    deinit {
        invalidateTimer()
    }
}
