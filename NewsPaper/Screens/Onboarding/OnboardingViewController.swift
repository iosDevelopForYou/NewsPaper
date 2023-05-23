//
//  OnboardingViewController.swift
//  NewsPaper
//
//  Created by Лариса Терегулова on 11.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var onboardingCVC = OnboardingCollectionViewCell()
    var currentPage = 0 {
        didSet {
            onboardingCVC.slidePageControl.currentPage = currentPage
            if currentPage == onboardingSlides.count - 1 {
                nextButton.setTitle("Get Start", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    var onboardingSlides: [OnboardingSlides] = [
        OnboardingSlides(image: UIImage(named: "1")!, title: "First to know", description: "All news in one place, be the first to know last news"),
        OnboardingSlides(image: UIImage(named: "2")!, title: "", description: "Different categories of news"),
        OnboardingSlides(image: UIImage(named: "3")!, title: "", description: "Save your favorite news")]
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        cv.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "purplePrimary")
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.addSubview(nextButton)
        addConstraints()
        self.navigationItem.hidesBackButton = true
    }

    
    func addConstraints() {
        NSLayoutConstraint.activate([self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                     self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7),
                                     
                                     nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
                                     nextButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     nextButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.07)])
    }

    @objc func nextPressed() {
        if currentPage == onboardingSlides.count - 1 {
            
            navigationController?.pushViewController(AutorizationViewController(), animated: true)
            print("push BrowseViewController")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    //MARK: -UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(onboardingSlides[indexPath.row], currentPage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingSlides.count
    }
    
    //MARK: -CommentUICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}

