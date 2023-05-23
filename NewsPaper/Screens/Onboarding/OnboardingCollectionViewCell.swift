//
//  OnboardingCollectionViewCell.swift
//  NewsPaper
//
//  Created by Лариса Терегулова on 12.05.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    var slideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
     var slidePageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
        control.pageIndicatorTintColor = UIColor(named: "greyLighter")
        control.currentPageIndicatorTintColor = UIColor(named: "purplePrimary")
        control.isUserInteractionEnabled = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
     var slideTitleLabel: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 24, weight: .regular)
        text.textColor = UIColor(named: "blackPrimary")
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
     var slideTextLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = .systemFont(ofSize: 16)
        text.textColor = UIColor(named: "greyPrimary")
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(slideImageView)
        self.contentView.addSubview(slidePageControl)
        self.contentView.addSubview(slideTitleLabel)
        self.contentView.addSubview(slideTextLabel)

        NSLayoutConstraint.activate([
            slideImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            slideImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            slideImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            slideImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            slidePageControl.topAnchor.constraint(equalToSystemSpacingBelow: slideImageView.bottomAnchor, multiplier: 0.2),
            slidePageControl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            slideTitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            slideTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: slidePageControl.bottomAnchor, multiplier: 2),
            slideTitleLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.04),
            slideTitleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            
            slideTextLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            slideTextLabel.topAnchor.constraint(equalToSystemSpacingBelow: slideTitleLabel.bottomAnchor, multiplier: 4),
            slideTextLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.8),
            slideTextLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.07)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setup(_ slides: OnboardingSlides, _ currentPage: Int) {
        slideImageView.image = slides.image
        slideTitleLabel.text = slides.title
        slideTextLabel.text = slides.description
        slidePageControl.currentPage = currentPage
    }
}
