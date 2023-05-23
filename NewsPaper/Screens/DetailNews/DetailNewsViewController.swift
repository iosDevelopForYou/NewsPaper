//
//  DetailNewsViewController.swift
//  NewsPaper
//
//  Created by Marat Guseynov on 08.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class DetailNewsViewController: UIViewController {
    
    var newsAll: News?
    var article: Article!
  //  var article = Article(source: Source(id: "1", name: "Publisher"), author: "John Doe", title: "The latest situation in the presidential election", description: "Изучаем основыОсновы – это касается прежде всего базовых школьных знаний алгебры. Математические операции: сложение, вычитание, умножение, деление, деление с остатком, округление, возведение в степень. Хорошо бы понимать что такое логарифмы и интегралы. Понятия инкремента, декремента.Дальше системы счисления, базовые типы данных (символьные, строковые, числовые, логические).Неплохо так же иметь представление об основах устройства компьютера (или по старинке ЭВМ), его основные элементы, как работает процессор, как устроена память (ОЗУ, ПЗУ). Знать и понимать, как работают Операционные Системы (ОС), что такое ядро, драйвера. В нашем случае нужно подружиться с MacOS, ведь весь процесс разработки происходит именно под этой системой.Сюда же относится изучение Интегрированной Среды Разработки (IDE) XCode, SwiftPlayground.Прежде всего хочу сказать, и даже скорее призвать тебя, дорогой читатель – УЧИ АНГЛИЙСКИЙ ЯЗЫК! Английский язык пригодится тебе в жизни во многих сферах, но для программирования он жизненно важен. IT это такое направление, где все развивается очень стремительно. Технологии постоянно обновляются и совершенствуются, выходят новые фреймворки. И ко всему этому документация и литература появляется прежде всего на английском языке. Множество различных API просто не имеют русского перевода, а их функционал тебя удивит. Что касается книг на русском, то в большинстве случаев перевод очень посредственный, либо эта информация уже устарела.", url: "https://www.npr.org/2023/04/04/1167991770/trump-arraignment-34-felony-counts-arraignment-new-york-court-election", urlToImage: "https://content.rollcall.com/wp-content/uploads/2023/03/afpi210_072622.jpg?fit=1240,698", publishedAt: "publishedAt", content: "content", favorites: false)
    
    private let topBackgroundImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        return contentView
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let autorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let publisherLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let openBrowserPageButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage.init(systemName: "arrowshape.turn.up.right"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let favoritesButton: UIButton = {
     //  let button = UIButton()
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = UIColor(named: "purplePrimary")
        button.addTarget(nil, action: #selector(likeTapped), for: .touchUpInside)
  //      return button
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setBackgroundImage(UIImage.init(systemName: "bookmark"), for: .normal)
//        button.tintColor = .white
//        button.addTarget(nil, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func likeTapped() {
        print("Нажали likeTapped в таблице")
        // тут логика добавления в избранное + смена внешнего вида кнопки (заливка)
         //   delegate?.didTapFavoriteButton2(in: self)
        
    }
    
    private func addView() {
        view.addSubview(topBackgroundImage)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTitleLabel)
        topBackgroundImage.addSubview(autorLabel)
        topBackgroundImage.addSubview(publisherLabel)
        topBackgroundImage.addSubview(titleLabel)
        topBackgroundImage.addSubview(openBrowserPageButton)
        topBackgroundImage.addSubview(favoritesButton)
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            topBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImage.heightAnchor.constraint(equalToConstant: 370),
      
            scrollView.topAnchor.constraint(equalTo: topBackgroundImage.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
 
            descriptionTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
     
            autorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 26),
            autorLabel.bottomAnchor.constraint(equalTo: topBackgroundImage.bottomAnchor, constant: -24),
      
            publisherLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 26),
            publisherLabel.bottomAnchor.constraint(equalTo: autorLabel.topAnchor),
    
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: publisherLabel.topAnchor,constant: -24),
            
            openBrowserPageButton.topAnchor.constraint(equalTo: topBackgroundImage.topAnchor, constant: 130),
            openBrowserPageButton.trailingAnchor.constraint(equalTo: topBackgroundImage.trailingAnchor, constant: -20),
            openBrowserPageButton.heightAnchor.constraint(equalToConstant: 18),
            openBrowserPageButton.widthAnchor.constraint(equalToConstant: 20),
            
            favoritesButton.bottomAnchor.constraint(equalTo: openBrowserPageButton.topAnchor, constant: -30),
            favoritesButton.trailingAnchor.constraint(equalTo: topBackgroundImage.trailingAnchor, constant: -24),
            favoritesButton.heightAnchor.constraint(equalToConstant: 20),
            favoritesButton.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
    
    func setupScreen(article: Article) {
        if let url = URL(string: article.urlToImage ?? "") {
            topBackgroundImage.kf.setImage(with: url)
            descriptionLabel.text = article.description
            autorLabel.text = article.author
            titleLabel.text = article.title
            publisherLabel.text = article.source?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Task {
//            do {
//                newsAll = try await NewsService.shared.topHeadlines()
//                article = newsAll?.articles?[0]
//                setupScreen(article: article!)
//            } catch {
//                print("Error =", error.localizedDescription)
//
//            }
//        }
        addView()
        layout()
        setupScreen(article: article)

        
        //MARK: - Custom nav bar back button config
        let backButtonImage = UIImage(named: "backButtonWhite")
        
        // Create a custom button with the image
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        
        // Create a UIBarButtonItem with the custom button
        let customBackButton = UIBarButtonItem(customView: backButton)
        
        // Set the custom button as the left bar button item
        self.navigationItem.leftBarButtonItem = customBackButton
        
    }
    // Function to handle the custom back button's tap event
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
}


