//
//  MemberPageViewController.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import UIKit

class MemberPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Member Page"
    }


    @IBAction func homeButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
