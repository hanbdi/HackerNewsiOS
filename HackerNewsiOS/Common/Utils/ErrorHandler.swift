//
//  ErrorHandler.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorHandler {
    func displayError(error: Error, completion: (() -> Void)?)
    func displayInfo(title: String, message: String, completion: (() -> Void)?)
}

// MARK: Default implementation

extension ErrorHandler where Self: UIViewController {
       
    func displayError(error: Error, completion: (() -> Void)? = nil) {        
        let title = Constants.ErrorMessage.title
        var message = Constants.ErrorMessage.friendlyMessage
        
        if let error = error as? AppError, error == .urlIsNil {
            message = Constants.ErrorMessage.invalidUrlMessage
        }
                
        displayInfo(title: title, message: message, completion: completion)
    }
    
    func displayInfo(title: String, message: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                completion?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
