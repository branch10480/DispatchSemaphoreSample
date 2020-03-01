//
//  ViewController.swift
//  DispatchQueueTest
//
//  Created by 今枝 稔晴 on 2020/03/01.
//  Copyright © 2020 今枝 稔晴. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let semaphore = DispatchSemaphore(value: 0)
            DispatchQueue.main.async {
                self.showAlert(title: "alert1", message: "message") {
                    semaphore.signal()
                }
            }
            semaphore.wait()

            DispatchQueue.main.async {
                self.showAlert(title: "alert2", message: "message") {
                    semaphore.signal()
                }
            }
            semaphore.wait()
        }
    }
    
    private func showAlert(title: String, message: String, completion: @escaping ()->Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(.init(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        self.present(ac, animated: true, completion: nil)
    }
    
}

