//
//  DetailView.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import Foundation
import UIKit

class DetailView : UIView {
    let posterImage : UIImageView = {
        let posterImage = UIImageView()
        return posterImage
    }()
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .white
        return titleLabel
    }()
    let rateLabel : UILabel = {
        var rateLabel = UILabel()
        rateLabel.backgroundColor = .white
        rateLabel.textAlignment = .center
        return rateLabel
    }()
    let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.backgroundColor = .white
        descriptionLabel.numberOfLines = 10
        return descriptionLabel
    }()
    init() {
        super.init(frame: UIScreen.main.bounds)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config() {
        addSubview(posterImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(rateLabel)
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            posterImage.widthAnchor.constraint(equalToConstant: 200),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            rateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            rateLabel.heightAnchor.constraint(equalToConstant: 20),
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            
            descriptionLabel.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 200),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
    }
}
