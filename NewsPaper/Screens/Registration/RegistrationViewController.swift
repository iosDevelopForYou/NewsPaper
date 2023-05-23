//
//  RegistrationViewController.swift
//  NewsPaper
//
//  Created by Marat Guseynov on 13.05.2023.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Hello, I guess you are new around here. You can start using the application after sign up."
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    //MARK: - userName textfield config
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 12
        textField.leftViewMode = .always
        textField.delegate = self
        textField.setLeftPaddingPoints(64)
        textField.placeholder = "User name"
        textField.textColor = .black
        return textField
    }()
    private let userNameTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "user")
        return image
    }()
    private let userNameTextFieldImageActivate: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "userActivate")
        return image
    }()
    
    //MARK: - Email textfield config
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 12
        textField.leftViewMode = .always
        textField.delegate = self
        textField.setLeftPaddingPoints(64)
        textField.placeholder = "Email adress"
        textField.textColor = .black
        textField.autocapitalizationType = .none
        return textField
    }()
    private let emailTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mailIcon")
        return image
    }()
    private let emailTextFieldImageActivate: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mailIconActivate")
        return image
    }()
    
    //MARK: - Password textfield config
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 12
        textField.leftViewMode = .always
        textField.delegate = self
        textField.setLeftPaddingPoints(64)
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldsDidChange(_:)), for: .editingChanged)
        return textField
    }()
    private let passwordTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "passwordIcon")
        return image
    }()
    private let passwordTextFieldImageActivate: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "passwordIconActivate")
        return image
    }()
    
    //MARK: - RepeatPassword textfield config
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 12
        textField.leftViewMode = .always
        textField.delegate = self
        textField.setLeftPaddingPoints(64)
        textField.placeholder = "Repeat password"
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldsDidChange(_:)), for: .editingChanged)
        return textField
    }()
    private let repeatPasswordTextFieldImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "passwordIcon")
        return image
    }()
    private let repeatPasswordTextFieldImageActivate: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "passwordIconActivate")
        return image
    }()
    
    //MARK: - Sign In label and button config
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor(named: "purplePrimary"), for: .normal)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    @objc private func signInButtonPressed(sender: UIButton) {
        sender.alpha = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Sign up button config
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "purplePrimary")
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    @objc private func signUpButtonPressed(sender: UIButton) {
        sender.alpha = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let repeatPassword = repeatPasswordTextField.text,
              password == repeatPassword else {
            // ошибка при проверке паролей
            self.alarmLabel.textColor = .systemRed
            self.alarmLabel.text = "Passwords do not match"
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // если есть ошибка, то выводим описание
                print(error.localizedDescription)
                self.alarmLabel.textColor = .systemRed
                self.alarmLabel.text = error.localizedDescription
            } else {
                // если пользователя создали успешно, то перегружаем предыдущий VC
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    //MARK: - Alarm label, compare textfields config
    
    private let alarmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    // Создание функции для обработки изменений в текстовых полях
    @objc func textFieldsDidChange(_ textField: UITextField) {
        // Получение значений из текстовых полей
        let text1 = passwordTextField.text ?? ""
        let text2 = repeatPasswordTextField.text ?? ""
        
        if text1.isEmpty || text2.isEmpty {
            alarmLabel.text = " "
        } else {
            // Сопоставление значений
            if text1 == text2 {
                alarmLabel.textColor = .systemGreen
                alarmLabel.text = "Password match"
            } else {
                alarmLabel.textColor = .systemRed
                alarmLabel.text = "Password doesnt match, try again"
            }
        }
    }
    
    private func addViewLayout() {
        view.addSubview(descriptionLabel)
        view.addSubview(userNameTextField)
        userNameTextField.addSubview(userNameTextFieldImage)
        view.addSubview(emailTextField)
        emailTextField.addSubview(emailTextFieldImage)
        view.addSubview(passwordTextField)
        passwordTextField.addSubview(passwordTextFieldImage)
        view.addSubview(repeatPasswordTextField)
        repeatPasswordTextField.addSubview(repeatPasswordTextFieldImage)
        view.addSubview(signUpButton)
        view.addSubview(signInLabel)
        view.addSubview(signInButton)
        view.addSubview(alarmLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //MARK: - username textfield constraint
            userNameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 56),
            
            userNameTextFieldImage.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor, constant: 18),
            userNameTextFieldImage.centerYAnchor.constraint(equalTo: userNameTextField.centerYAnchor),
            //MARK: - Email textfield constraint
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            emailTextFieldImage.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 18),
            emailTextFieldImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            //MARK: - Password textfield constraint
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            passwordTextFieldImage.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 18),
            passwordTextFieldImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            
            //MARK: - RepeatPassword textfield constraint
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            repeatPasswordTextFieldImage.leadingAnchor.constraint(equalTo: repeatPasswordTextField.leadingAnchor, constant: 18),
            repeatPasswordTextFieldImage.centerYAnchor.constraint(equalTo: repeatPasswordTextField.centerYAnchor),
            
            //MARK: - Sign up button
            signUpButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 64),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            
            //MARK: - Sign in label and button
            signInLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 66),
            
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -66),
            //MARK: - Alarm label
            alarmLabel.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10),
            alarmLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViewLayout()
        
        // hides back nav button
        self.navigationItem.hidesBackButton = true
        
        //MARK: - large font nav bar
        self.title = "Welcome to NewsToDay"
        // Create large title font
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.firstLineHeadIndent = 0.0
                return style
            }()
        ]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: - Hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "purplePrimary")?.cgColor
        textField.backgroundColor = .white
        
        if textField == userNameTextField {
            userNameTextField.addSubview(userNameTextFieldImageActivate)
            NSLayoutConstraint.activate([
                userNameTextFieldImageActivate.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor, constant: 18),
                userNameTextFieldImageActivate.centerYAnchor.constraint(equalTo: userNameTextField.centerYAnchor)
            ])
        } else if textField == emailTextField {
            emailTextField.addSubview(emailTextFieldImageActivate)
            NSLayoutConstraint.activate([
                emailTextFieldImageActivate.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 18),
                emailTextFieldImageActivate.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor)
            ])
        } else if textField == passwordTextField {
            passwordTextField.addSubview(passwordTextFieldImageActivate)
            NSLayoutConstraint.activate([
                passwordTextFieldImageActivate.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 18),
                passwordTextFieldImageActivate.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor)
            ])
        } else if textField == repeatPasswordTextField {
            repeatPasswordTextField.addSubview(repeatPasswordTextFieldImageActivate)
            NSLayoutConstraint.activate([
                repeatPasswordTextFieldImageActivate.leadingAnchor.constraint(equalTo: repeatPasswordTextField.leadingAnchor, constant: 18),
                repeatPasswordTextFieldImageActivate.centerYAnchor.constraint(equalTo: repeatPasswordTextField.centerYAnchor)
            ])
        }
    }
}



