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
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let semaphore = DispatchSemaphore(value: 0)
            self.process(semaphore: semaphore, title: "Alert1", message: "This is Alert1.")
            self.process(semaphore: semaphore, title: "Alert2", message: "This is Alert2.")
            self.process(semaphore: semaphore, title: "Alert3", message: "This is Alert3.")
        }
    }
    
    private func process(semaphore: DispatchSemaphore, title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title: title, message: message) {
                semaphore.signal()
            }
        }
        semaphore.wait()
    }
    
    private func showAlert(title: String, message: String, completion: @escaping ()->Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(.init(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        self.present(ac, animated: true, completion: nil)
    }
    
}

