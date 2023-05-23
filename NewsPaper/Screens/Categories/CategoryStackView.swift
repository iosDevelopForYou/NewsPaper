//
//  CategoryStackView.swift
//  NewsPaper
//
//  Created by Sofya Olekhnovich on 10.05.2023.
//

import UIKit

class CategoryStackView: UIStackView {

    var leftStack = UIStackView()
    var rightStack = UIStackView()
    var isLeft = true
    
    init(){
        super.init(frame: .zero)
        setMainStack()
        setSubstack(leftStack)
        setSubstack(rightStack)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func addSubview(categoryButton: CategoryButton) {
        let subview = isLeft ? leftStack : rightStack
        subview.addArrangedSubview(categoryButton)
        isLeft = !isLeft
    }
    
    private func setMainStack() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .top
        self.spacing = 16
        self.sizeToFit()
    }
    
    private func setSubstack(_ stack: UIStackView) {
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.sizeToFit()
        self.addArrangedSubview(stack)
    }
}
