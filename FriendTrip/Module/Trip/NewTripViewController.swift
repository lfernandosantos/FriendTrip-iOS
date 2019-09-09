//
//  NewTrip.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 04/09/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

final class NewTripViewController: UIViewController {

    
    @IBOutlet weak var nameTextView: CustomTextField!
    @IBOutlet weak var dataTextField: CustomTextField!
    @IBOutlet weak var hourTextField: CustomTextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var createButton: UIButton!
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [#colorLiteral(red: 0.9449999928, green: 0.5070000291, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.9309999943, green: 0.2129999995, blue: 0.5770000219, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        self.createButton.layer.cornerRadius = 8
        self.descriptionTextView.layer.cornerRadius = 8
    }
 
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTrip(_ sender: Any) {
        guard let name = nameTextView.textField.text,
            let date = dataTextField.textField.text,
            let hour = hourTextField.textField.text,
        let descriptionTrip = descriptionTextView.text else {
                print("Error to get texts.")
                return
        }
        
        let loginViewModel = LoginViewModel()
        guard let user = loginViewModel.getUser() else {
            print("Erro to get User.")
            return
        }
        
        let tripViewModel = TripViewModel(user: user)
        
        let trip = Trip(name: name, latitude: "1111", longitude: "1111", date: date, creator: user.id, description: descriptionTrip, status: "Created")
        
        tripViewModel.create(trip: trip) { success in
            if success {
                self.showAlert(msg: "Criado com sucesso!")
            } else {
                self.showAlert(msg: "Erro ao criar Trip!")
            }
        }
    }
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y , width: self.view.frame.width, height: self.view.frame.size.height)
            }
        } else if sender.state == .ended || sender.state == .cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }
            }
        }
        
    }
}
