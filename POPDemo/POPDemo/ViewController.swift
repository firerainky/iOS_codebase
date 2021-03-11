//
//  ViewController.swift
//  POPDemo
//
//  Created by Zheng Kanyan on 2021/3/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendRequest(_ sender: Any) {
        URLSessionClient().send(UserURLRequest()) { manyUser in
            if let manyUser = manyUser {
                print(manyUser)
            }
        }
    }
    
}

