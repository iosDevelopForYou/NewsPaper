//
//  CategoryCell.swift
//  NewsPaper
//
//  Created by Sofya Olekhnovich on 10.05.2023.
//

import UIKit

class CategoryButton: UIButton {
    static var wasChanged = false
    static var selectedNames = Set<String>()
    var category: CategoryModel
    
    init(category: CategoryModel) {
        self.category = category
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementation")
    }
    
    private func setup() {
        setButton()
        setTitle()
        setConstraints()
        setDependsOn(isSelected: category.isSelected)
    }
    
    // MARK: - Title
    
    private func setTitle() {
        setTitle(category.title, for: .normal)
    }
    
    // MARK: - Button
    
    private func setButton() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0.953, green: 0.955, blue: 0.967, alpha: 1).cgColor
        
        self.addTarget(self, action: #selector(onButtonPressed(sender:)), for: .touchUpInside)
    }
    
    // OnButtonPressed
    
    @objc func onButtonPressed(sender: UIButton) {
        CategoryButton.wasChanged = true
        category.isSelected = !category.isSelected
        setDependsOn(isSelected: category.isSelected)
    }
    
    
    // MARK: - Depends on selected mode
    
    func setDependsOn(isSelected: Bool) {
        category.isSelected = isSelected
        self.backgroundColor = isSelected ? UIColor(named: "purplePrimary") : .white
        let titleColor: UIColor = isSelected ? .white : .black
        setTitleColor(titleColor, for: .normal)
        if isSelected {
            CategoryButton.selectedNames.insert(category.name)
        } else {
            CategoryButton.selectedNames.remove(category.name)
        }
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        // button
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 72).isActive = true
    }
}
