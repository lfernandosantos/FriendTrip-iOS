//
//  LoginViewController.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var defaultButton: UIButton!
    var loginViewModel = LoginViewModel()
    
    let indicatorView: UIView = {
        let uiview = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        uiview.layer.cornerRadius = 4
        uiview.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return uiview
    }()
    
    let alert: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.white
        loadingIndicator.startAnimating()
        return loadingIndicator
    }()

    private func setUpView() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [#colorLiteral(red: 0.9449999928, green: 0.5070000291, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.9309999943, green: 0.2129999995, blue: 0.5770000219, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
        self.setUp()
    }
    
    func setUp() {
        self.showLoading()
        self.loginViewModel.alreadyLogin { (sucess) in
            self.dismiss(animated: true, completion: nil)
            self.hideLoading()
            if sucess {
                self.goHome()
            } else {
                self.loginViewModel.loginDelegate = self
                self.addFBLoginButton()
            }
        }
    }

    private func addFBLoginButton(){
        DispatchQueue.main.async {
            
            let btnFace = FBLoginButton()
            btnFace.permissions = [FacebookLoginParams.PROFILE.rawValue,
                                   FacebookLoginParams.EMAIL.rawValue,
                                   FacebookLoginParams.USER_FRIENDS.rawValue]
            
            btnFace.center = self.view.center
            btnFace.frame.size.width = 2
            btnFace.frame.size.height = 2
            btnFace.delegate = self.loginViewModel
            self.view.addSubview(btnFace)
            
            UIView.animate(withDuration: 0.7) {
                btnFace.frame = self.defaultButton.frame
            }
        }
    }
    
    private func goHome() {
        self.performSegue(withIdentifier: "goHome", sender: nil)
    }
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    
    func showLoading(){
        
        DispatchQueue.main.async {
            
            self.indicatorView.addSubview(self.alert)
            self.view.addSubview(self.indicatorView)
            self.indicatorView.center = self.view.center
            self.alert.startAnimating()
            self.alert.center = self.view.center
            self.alert.frame = self.indicatorView.bounds
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.alert.stopAnimating()
            self.indicatorView.removeFromSuperview()
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func didLogin(result: RequestResult<Bool, String?>) {
        switch result {
        case .success(_ ):
            print("Sucesso")
            goHome()
        case .failure(let error):
            guard let error = error else {
                self.showAlert(msg: "Generic Error!\nTry Again!")
                return
            }
            showAlert(msg: error)
        }
    }
}


