//
//  DetailViewController.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    let detailView = DetailView()
    var detailTitle : String = ""
    var detailDescription : String = ""
    var detailImage = UIImage()
    var detailRate = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        detailView.titleLabel.text = detailTitle
        detailView.descriptionLabel.text = detailDescription
        detailView.posterImage.image = detailImage
        detailView.rateLabel.text = "Rate: \(detailRate)/100"
        view.addSubview(detailView)
        setSafeArea()
    }
    func setSafeArea() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
