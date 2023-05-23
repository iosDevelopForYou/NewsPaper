//
//  CategoriesView.swift
//  NewsPaper
//
//  Created by Sofya Olekhnovich on 09.05.2023.
//

import UIKit

class CategoriesView: UIView {
    
    var isOnboarding: Bool
    var headerText: String
    var infoText: String
    
    let sideOffset: CGFloat = 20
    var stack = UIStackView()

    private lazy var header: UILabel = {
        var header = UILabel()
        header.frame = CGRect(x: 0, y: 0, width: 128, height: 32)
        header.text = headerText
        header.textColor = UIColor(red: 0.2, green: 0.212, blue: 0.278, alpha: 1)
        header.font = UIFont(name: "Inter-SemiBold", size: 24)
        return header
    }()
    
     private lazy var info: UILabel = {
        var info = UILabel()
         info.frame = CGRect(x: 0, y: 0, width: 295, height: 24)
         info.text = infoText
         info.textColor = UIColor(red: 0.488, green: 0.51, blue: 0.632, alpha: 1)
         info.font = UIFont(name: "Inter-Regular", size: 16)
         info.numberOfLines = 2
         info.sizeToFit()
        return info
    }()
    
    private lazy var nextButton: UIButton = {
        var button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = UIColor(named: "purplePrimary")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(goToMain(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func goToMain(sender: UIButton!){
        let newViewController = TabBarViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = newViewController
            window.makeKeyAndVisible()
        }
    }
    
    init(isOnboarding: Bool, header: String, info: String) {
        self.isOnboarding = isOnboarding
        self.headerText = header
        self.infoText = info
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUIElements(stack : UIStackView) {
        backgroundColor = .white
        self.stack = stack
      //  addSubview(header)
        addSubview(info)
        addSubview(stack)
        if (isOnboarding) {
            addSubview(nextButton)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        // header
//        header.translatesAutoresizingMaskIntoConstraints = false
//        header.topAnchor.constraint(equalTo: self.topAnchor, constant: 72).isActive = true
//        header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideOffset).isActive = true
//        header.heightAnchor.constraint(equalToConstant: 32).isActive = true
//
        // info
        info.translatesAutoresizingMaskIntoConstraints = false
        info.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        info.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideOffset).isActive = true
        info.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideOffset).isActive = true
        
        // stackView
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: info.bottomAnchor, constant: 32).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        // buuton
        if (!isOnboarding) {
            return
        }
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideOffset).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideOffset).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}
