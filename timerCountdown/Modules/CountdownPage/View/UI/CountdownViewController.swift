//
//  CountdownViewController.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import UIKit
import Combine

class CountdownViewController: UIViewController {
    // initialize the viewmodel
    private var viewModel = CountdownViewModel(service: APIService())
    
    private var cancellables = Set<AnyCancellable>()
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countdown"
        bindViewModel()
        viewModel.fetchInitialDuration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.invalidateTimer()
    }
    
    func bindViewModel(){
        viewModel.$timeRemainingText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.proceedButton.setTitle("Proceed in \(text)", for: .normal)
            }
            .store(in: &cancellables)

        viewModel.$isButtonEabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.proceedButton.isEnabled = isEnabled
                self?.proceedButton.setTitle("Proceed", for: .normal)
            }
            .store(in: &cancellables)
        
        viewModel.$showValidationSuccess
                   .filter { $0 }
                   .receive(on: DispatchQueue.main)
                   .sink { _ in
                       self.navigateToNextScreen()
                       print("✅ Server validation successful.")
                   }
                   .store(in: &cancellables)

        viewModel.$showValidationError
                   .filter { $0 }
                   .receive(on: DispatchQueue.main)
                   .sink { _ in
                       print("❌ Server validation failed.")
                   }
                   .store(in: &cancellables)
    }
  
    @IBAction func proceedButtonTapped(_ sender: Any) {
        viewModel.validateButtonAction()
        self.proceedButton.setTitle("Loading...", for: .normal)
    }
    
    private func navigateToNextScreen() {
        let vc = MemberPageViewController(nibName: "MemberPageViewController", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
