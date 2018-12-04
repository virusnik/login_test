//
//  ViewController.swift
//  login_test
//
//  Created by Sergio Veliz on 10/23/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import UIKit

let alphaZero: CGFloat = 0.0
let alphaFifty: CGFloat = 0.5
let alphaEighty: CGFloat = 0.7

var iconEmailImage: UIImage = UIImage(named: "ic_email")!
var iconPasswordImage: UIImage = UIImage(named: "ic_lock")!

class AuthVC: UIViewController {
    
    let logoView: UIView = {
        let logoView = UIView()
        logoView.frame = CGRect(x: 0, y: 0, width: 138, height: 138)
        logoView.layer.cornerRadius = logoView.frame.height / 2
        logoView.clipsToBounds = true
        logoView.backgroundColor = .clear
        logoView.layer.borderColor = UIColor.white.cgColor
        logoView.layer.borderWidth = 5
        logoView.alpha = alphaZero
        return logoView
    }()
    
//    var logoTitle = UILabel()
    let logoTitle: UILabel = {
        let logoTitle = UILabel()
        logoTitle.text = "YM"
        logoTitle.textColor = .white
        logoTitle.font = UIFont.systemFont(ofSize: 30)
//        logoTitle.numberOfLines = 1
        logoTitle.minimumScaleFactor = 0.9
        logoTitle.textAlignment = .center
        
        return logoTitle
    }()
    
//    var stackViewLogo = UIStackView()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.loginButton, self.signInButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20.0
        stackView.alpha = alphaZero
        return stackView
    }()

    let signInButton: UIButton = {
        let signInButton = UIButton(type: UIButton.ButtonType.system)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        signInButton.setTitleColor(UIColor(white: 1, alpha: alphaEighty), for: .normal)
//        signInButton.backgroundColor = .black
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        signInButton.backgroundColor = .clear
        signInButton.layer.borderColor = UIColor(white: 1, alpha: alphaEighty).cgColor
        signInButton.layer.borderWidth = 1
        signInButton.clipsToBounds = true
        signInButton.tag = 2
        signInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return signInButton
    }()
//    var loginButton = UIButton()
    let loginButton: UIButton = {
        let loginButton = UIButton(type: UIButton.ButtonType.system)
        loginButton.setTitle("Login In", for: .normal)
        loginButton.setTitleColor(UIColor(white: 1, alpha: alphaEighty), for: .normal)
        loginButton.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
//        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .clear
        
        loginButton.layer.borderColor = UIColor(white: 1, alpha: alphaEighty).cgColor
        loginButton.layer.borderWidth = 1
        loginButton.clipsToBounds = true
        loginButton.tag = 1
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    lazy var fieldsStackView: UIStackView = {
        let fieldStackView = UIStackView(arrangedSubviews: [self.emailField, self.passwordField])
        fieldStackView.axis = .vertical
        fieldStackView.distribution = .fillEqually
        fieldStackView.spacing = 20.0
        fieldStackView.alpha = alphaZero
        return fieldStackView
    }()
    
    
    let emailField: UITextField = {
        let emailField = UITextField()
        emailField.keyboardType = UIKeyboardType.emailAddress
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor(white: 1, alpha: alphaEighty).cgColor
        emailField.textColor = UIColor(white: 1, alpha: alphaEighty)
        emailField.tintColor = UIColor(white: 1, alpha: alphaEighty)
        emailField.attributedPlaceholder =
            NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailField.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        emailField.layer.cornerRadius = 15
        emailField.clipsToBounds = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 2.0))
        emailField.leftView = leftView
        emailField.leftViewMode = .always
//        emailField.placeholder = "email"
        return emailField
    }()
    
    let passwordField: UITextField = {
       let passwordField = UITextField()
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor(white: 1, alpha: alphaEighty).cgColor
        passwordField.textColor = UIColor(white: 1, alpha: alphaEighty)
        passwordField.tintColor = UIColor(white: 1, alpha: alphaEighty)
        passwordField.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        passwordField.layer.cornerRadius = 15
        passwordField.clipsToBounds = true
        passwordField.attributedPlaceholder =
            NSAttributedString(string: "• • • • •", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 2.0))
        passwordField.isSecureTextEntry = true
        passwordField.leftView = leftView
        passwordField.leftViewMode = .always
        return passwordField
        
    }()
    
    let iconEmail: UIImageView = {
       let iconEmail = UIImageView()
        iconEmail.image = iconEmailImage
        iconEmail.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return iconEmail
    }()
    
    let iconPassword: UIImageView = {
       let iconPassword = UIImageView()
        iconPassword.image = iconPasswordImage
        iconPassword.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return iconPassword
    }()
    
    private var yConstraint: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        DispatchQueue.main.async {
            self.hundleConstraints()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleTap(_:))
            )
        )
        
        registerForKeyboardNotifications()
    }
    
    func hundleConstraints() {
        
        // Logo View contsraints
        logoView.translatesAutoresizingMaskIntoConstraints = false
        UIView.animate(withDuration: 1.0, animations: { self.logoView.alpha = alphaFifty
            self.logoView.frame.origin.y = -100
            self.view.setNeedsDisplay() })
        self.view.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 138),
            logoView.heightAnchor.constraint(equalToConstant: 138),
            logoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            logoView.bottomAnchor.constraint(equalTo: self.fieldsStackView.bottomAnchor, constant: 50),
//            logoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        
        // Logo Title contsraints
        logoTitle.translatesAutoresizingMaskIntoConstraints = false
        UIView.animate(withDuration: 1.0, animations: { self.logoTitle.alpha = alphaFifty
            self.view.setNeedsDisplay() })
        self.logoView.addSubview(logoTitle)
        NSLayoutConstraint.activate([
            logoTitle.widthAnchor.constraint(equalToConstant: 100),
            logoTitle.heightAnchor.constraint(equalToConstant: 50),
            logoTitle.centerYAnchor.constraint(equalTo: self.logoView.centerYAnchor),
            logoTitle.centerXAnchor.constraint(equalTo: self.logoView.centerXAnchor),])
        
        // Stack View constraints
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        UIView.animate(withDuration: 2.0, animations: { self.buttonStackView.alpha = alphaEighty })
        self.view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.widthAnchor.constraint(equalToConstant: 250),
            buttonStackView.heightAnchor.constraint(equalToConstant: 120),
            buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            buttonStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ])
        
        yConstraint = buttonStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([
            yConstraint])
        
        fieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fieldsStackView)
        
        NSLayoutConstraint.activate([
            fieldsStackView.widthAnchor.constraint(equalToConstant: 250),
            fieldsStackView.heightAnchor.constraint(equalToConstant: 120),
            fieldsStackView.bottomAnchor.constraint(equalTo: self.buttonStackView.bottomAnchor, constant: -140),
//            fieldsStackView.topAnchor.constraint(equalTo: self.logoView.topAnchor, constant: 10),
//            fieldsStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
//            fieldsStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            fieldsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        
        iconEmail.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.addSubview(iconEmail)
        NSLayoutConstraint.activate([
            iconEmail.leadingAnchor.constraint(equalTo: self.emailField.leadingAnchor, constant: 10),
            iconEmail.centerYAnchor.constraint(equalTo: self.emailField.centerYAnchor),
            ])
        
        iconPassword.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.addSubview(iconPassword)
        NSLayoutConstraint.activate([
            iconPassword.leadingAnchor.constraint(equalTo: self.passwordField.leadingAnchor, constant: 10),
            iconPassword.centerYAnchor.constraint(equalTo: self.passwordField.centerYAnchor),
            ])
        
    }
    
    // MARK: - Actions
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let btnSendTag: UIButton = sender
        if btnSendTag.tag == 1 {
            print("login")
            animateButtonDown()
            signInButton.alpha = 0
        }
        if btnSendTag.tag == 2 {
            print("signin")
           
        }
    }

    func animateButtonDown() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.loginButton.frame.origin.y = 70
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.fieldsStackView.alpha = alphaEighty
            self.fieldsStackView.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - Notifications
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16)
        yConstraint.constant = -(keyboardHeight + 32)
        
        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: options, animations: {
            self.logoView.alpha = alphaZero
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc internal func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16)
        yConstraint.constant = -20
        
        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
            self.logoView.alpha = alphaEighty
        }, completion: nil)
        
    }
    

}

