//
//  CategoryCollectionViewCell.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 8.05.23.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private let categoryCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            updateSelectionAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(categoryCellView)
        categoryCellView.addSubview(categoryTitleLabel)
        
        categoryCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        categoryTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        updateSelectionAppearance()
    }
    
    private func updateSelectionAppearance() {
        categoryCellView.backgroundColor = isSelected ? UIColor(named: "purplePrimary") : .systemGray6
        categoryTitleLabel.textColor = isSelected ? .white : .gray
    }
    
    func configureCell(title: String) {
        categoryTitleLabel.text = title
    }
}
