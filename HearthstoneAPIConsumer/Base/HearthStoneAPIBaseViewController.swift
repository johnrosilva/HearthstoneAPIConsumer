//
//  HearthStoneAPIBaseViewController.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 30/05/23.
//

import UIKit

class HearthStoneAPIBaseViewController: UIViewController {
    
    private var loadingIndicator: UIActivityIndicatorView!
    public var alertView: UIAlertController?
    
    public func showLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator.startAnimating()
    }

    public func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.removeFromSuperview()
        }
    }
    
    public func showAlert(message: String) {
        DispatchQueue.main.async {
            self.alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            self.alertView?.addAction(okAction)
            
            if let alert = self.alertView {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
