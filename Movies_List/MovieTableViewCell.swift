//
//  MovieTableViewCell.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import Foundation
import UIKit
protocol MovieTableViewCellDelegate {
    func tapCell(cell : MovieTableViewCell)
    func tapFavouriteButton(cell: MovieTableViewCell)
    func tapviewedButton(cell: MovieTableViewCell)
}
class MovieTableViewCell: UITableViewCell {
    var delegate : MovieTableViewCellDelegate?
    var title : String?
    var id : String?
    var favouriteSelected: Bool?
    var viewed: Bool?
    var myMovie : MovieModelTitle?
    
    lazy var movieTitle : UILabel = {
        let movieTitle = UILabel(frame: CGRect(x: 20, y: 7.5, width: UIScreen.main.bounds.width - 125, height: 30))
        movieTitle.textColor = .black
        movieTitle.font = movieTitle.font.withSize(15)
        return movieTitle
    }()
    lazy var cellButton : UIButton = {
        let cellButton = UIButton()
        cellButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 105, height: UIScreen.main.bounds.height)
        cellButton.addTarget(self, action: #selector(tapCell), for: .touchUpInside)
        return cellButton
    }()
    lazy var favouriteButton : UIButton = {
        let favouriteButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 5, width: 35, height: 35))
        favouriteButton.setImage(UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15))), for: .normal)
        favouriteButton.setImage(UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15))), for: .selected)
        favouriteButton.addTarget(self, action: #selector(tapFavouriteButton), for: .touchUpInside)
        return favouriteButton
    }()
    lazy var viewedButton : UIButton = {
        let viewedButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 100, y: 5, width: 35, height: 35))
        viewedButton.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15))), for: .normal)
        viewedButton.setImage(UIImage(systemName: "eye.slash.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15))), for: .selected)
        viewedButton.addTarget(self, action: #selector(tapViewedButton), for: .touchUpInside)
        return viewedButton
    }()
    @objc func tapViewedButton() {
        delegate?.tapviewedButton(cell: self)
        viewedButton.isSelected.toggle()
    }
    @objc func tapFavouriteButton() {
        delegate?.tapFavouriteButton(cell: self)
        favouriteButton.isSelected.toggle()
    }
    @objc func tapCell() {
        delegate?.tapCell(cell: self)
        print("Button Tapped")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(movieTitle)
        contentView.addSubview(viewedButton)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(cellButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell (movie: String) {
        movieTitle.text = movie
    }
}
