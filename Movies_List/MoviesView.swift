//
//  MoviesView.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import Foundation
import UIKit

class MoviesView: UIView{
    var moviesTableView : UITableView = {
        let moviesTableView = UITableView()
        moviesTableView.allowsSelection = false
        moviesTableView.backgroundColor = .white
        //moviesTableView.separatorStyle = .none
        return moviesTableView
    }()
    var searchField : UITextField = {
        let searchField = UITextField()
        //searchField.text = "Search Movie"
        searchField.borderStyle = .bezel
        searchField.placeholder = "Search Movie"
        searchField.textColor = .black
        searchField.backgroundColor = .white
        return searchField
    }()
    var searchButton : UIButton = {
        let searchButton = UIButton()
        searchButton.setTitle("GO", for: .normal)
        searchButton.backgroundColor = .blue        
        return searchButton
    }()
    var favouriteButtonItem : UIBarButtonItem = {
        let favouriteButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"))
        return favouriteButtonItem
    }()
    init() {
        super.init(frame: UIScreen.main.bounds)
        config()
    }
    func config() {
        addSubview(moviesTableView)
        addSubview(searchField)
        addSubview(searchButton)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            searchButton.topAnchor.constraint(equalTo: topAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 50),
            
            searchField.topAnchor.constraint(equalTo: topAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            searchField.widthAnchor.constraint(equalToConstant: 200),
            
            moviesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
