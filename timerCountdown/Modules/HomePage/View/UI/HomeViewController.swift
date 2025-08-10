//
//  ViewController.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Home"
    }

    @IBAction func proceedButtonTapped(_ sender: Any) {
        debugPrint("proceedButtonTapped!")
        
        let vc = CountdownViewController(nibName: "CountdownViewController", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

