//
//  MainTableViewCell.swift
//  NewsPaper
//
//  Created by Alexandr Rodionov on 9.05.23.
//

import UIKit
import SnapKit
import Kingfisher

protocol FavoriteButtonDelegate2: AnyObject {
    func didTapFavoriteButton2(in cell: MainTableViewCell)
}

class MainTableViewCell: UITableViewCell {
    
    weak var delegate: FavoriteButtonDelegate2?
    
    static let identifier = "MainTableCell"
    
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let articleImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemGray2
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = UIColor(named: "purplePrimary")
        button.addTarget(nil, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func likeTapped() {
        print("Нажали likeTapped в таблице")
        // тут логика добавления в избранное + смена внешнего вида кнопки (заливка)
            delegate?.didTapFavoriteButton2(in: self)
        
    }
    
    private let tableCellTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover things of this world Discover things of this world"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    private let articleAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover things of this world "
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Настраиваем внешний вид ячейки
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(mainView)
        mainView.addSubview(articleImageView)
        mainView.addSubview(likeButton)
        mainView.addSubview(articleAuthorLabel)
        mainView.addSubview(tableCellTitleLabel)
    }
    
    func setupConstraints() {
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-10)
            $0.height.equalTo(100)
        }
        
        articleImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(mainView)
            $0.width.equalTo(100)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(mainView.snp.trailing).inset(15)
            $0.top.equalTo(mainView.snp.top).inset(15)
            $0.width.height.equalTo(20)
        }
        
        articleAuthorLabel.snp.makeConstraints {
            $0.leading.equalTo(articleImageView.snp.trailing).offset(10)
            $0.top.equalTo(mainView.snp.top).offset(25)
            $0.trailing.equalTo(mainView.snp.trailing).inset(10)
        }
        
        tableCellTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(articleImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(mainView.snp.trailing).inset(10)
            $0.bottom.equalTo(mainView.snp.bottom)
            $0.height.equalTo(60)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(article: Article) {
        tableCellTitleLabel.text = article.title
        articleAuthorLabel.text = article.author
        let url = URL(string: article.urlToImage ?? "")
        let placeholderImage = UIImage(systemName: "photo.circle.fill")
        articleImageView.kf.setImage(with: url, placeholder: placeholderImage)
        if article.favorites == true {
            likeButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
}
