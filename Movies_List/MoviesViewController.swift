//
//  ViewController.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import UIKit
import Network

class MoviesViewController: UIViewController {
    let moviesView = MoviesView()
    var moviesJson : [MovieModelTitle]?
    var movieTitle: String = "War"
    var defaults = UserDefaults.standard
    var favoritesIdList : [String] = []
    var viewedIdList : [String] = []
    var moviesJsonId : [MovieModelId]?
    var showFavorites: Bool = true
    let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        moviesView.moviesTableView.delegate = self
        moviesView.moviesTableView.dataSource = self
        moviesView.moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        view.addSubview(moviesView)
        navigationItem.rightBarButtonItem = moviesView.favouriteButtonItem
        moviesView.favouriteButtonItem.action = #selector(tapFavouriteButtonItem)
        favoritesIdList = defaults.object(forKey: "FavoritesArray") as? [String] ?? []
        viewedIdList = defaults.object(forKey: "ViewedArray") as? [String] ?? []
        moviesView.searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
        observeConnection()
        
        setSafeArea()
        getFavoritesMovies()
    }
    func observeConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
                let alert = UIAlertController(title: "Alert", message: "No Connection", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {_ in
                    self.getFavoritesMovies()
                    print("Retrying")}))
                self.present(alert, animated: true, completion: nil)
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    @objc func tapFavouriteButtonItem() {
        getFavoritesMovies()
    }
    func getFavoritesMovies() {
        self.title = "Favorites"
        moviesJsonId = []
        showFavorites = true
        for movieId in favoritesIdList {
            MoviesApi.fetchMoviesJsonById(id: movieId) { result in
                switch result {
                case .success(let json):
                    DispatchQueue.main.async {
                        self.title = "Favorites"
                        print("IdJson correct\(json.title)")
//                        for viewdMovie in self.viewedIdList where json.imdbid != viewdMovie {
//                            self.moviesJsonId!.append(json)
//                        }
                        self.moviesJsonId!.append(json)
                        self.moviesView.moviesTableView.reloadData()
                    }
                case .failure(let error):
                    print("error")
                    print(error)
                }
            }
        }
    }
    func filterViewedMoviesTitle(titleMovies: [MovieModelTitle]) -> [MovieModelTitle] {
        var filteredMovies: [MovieModelTitle] = []
        
            for viewedMovie in viewedIdList {
                 filteredMovies = titleMovies.filter {
                    $0.id != viewedMovie
            }
        }
        return filteredMovies
    }
//    func filterViewedMoviesId(favMovies: [MovieModelId]) -> [MovieModelId] {
//        var filteredMovies: [MovieModelId] = []
//
//            for viewedMovie in viewedIdList {
//                 filteredMovies = favMovies.filter {
//                    $0.imdbid != viewedMovie
//            }
//        }
//        return filteredMovies
//    }
    @objc func tapSearchButton() {
        showFavorites = false
        movieTitle = moviesView.searchField.text!
        let replacedTest = movieTitle.replacingOccurrences(of: " ", with: "%20")
        movieTitle = replacedTest
        print(replacedTest)
        getSearchedMovies()
    }
    func setSafeArea() {
        moviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            moviesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            moviesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    func getSearchedMovies() {
        
        MoviesApi.fetchMoviesJsonByTitle(searchMovie: movieTitle) { result in
            switch result {
                
            case .success(let json):
                DispatchQueue.main.async {
                    print("Json download")
                    self.title = "Founded Movies"
                    self.moviesJson = json
                    self.moviesJson = self.filterViewedMoviesTitle(titleMovies: self.moviesJson!)
                    self.moviesView.moviesTableView.reloadData()
                }
                
            case .failure(let error):
                print("error")
                print(error)
            }
        }
    }
}
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch showFavorites {
        case true:
            if moviesJsonId != nil && favoritesIdList != []  {
                return moviesJsonId!.count
            } else{
                return 0
            }
        case false:
            if let moviesJson = moviesJson {
                return moviesJson.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        //cell.backgroundColor = .green
        if showFavorites == true {
            let myMovie = self.moviesJsonId?[indexPath.row]
            guard let myMovie = myMovie else {
                return cell
            }
            cell.configureCell(movie: myMovie.title)
            cell.title = myMovie.title
            cell.id = myMovie.imdbid
            
            if viewedIdList.contains(cell.id!){
                
                cell.viewed = true
                cell.viewedButton.isSelected = true
            } else {
                cell.viewed = false
                cell.viewedButton.isSelected = false
            }
            
            if favoritesIdList.contains(cell.id!){
                cell.favouriteSelected = true
                cell.favouriteButton.isSelected = true
            } else {
                cell.favouriteSelected = false
                cell.favouriteButton.isSelected = false
            }
            cell.delegate = self
            return cell
        }
        if showFavorites == false {
            let myMovie = self.moviesJson?[indexPath.row]
            guard let myMovie = myMovie else {
                return cell
            }
            cell.id = myMovie.id
            cell.configureCell(movie: myMovie.title)
            cell.title = myMovie.title
            
            
            if viewedIdList.contains(cell.id!){
                cell.viewed = true
                cell.viewedButton.isSelected = true
            } else {
                cell.viewed = false
                cell.viewedButton.isSelected = false
            }
            
            if favoritesIdList.contains(cell.id!){
                cell.favouriteSelected = true
                cell.favouriteButton.isSelected = true
            } else {
                cell.favouriteSelected = false
                cell.favouriteButton.isSelected = false
            }
            cell.delegate = self
            return cell
        }

        cell.delegate = self
        return cell
    }
}
extension MoviesViewController : MovieTableViewCellDelegate {
    func tapviewedButton(cell: MovieTableViewCell) {
        print("Viewed tapped")
        cell.viewed!.toggle()
        if cell.viewed == true {
            viewedIdList.append(cell.id!)
            cell.viewedButton.isSelected = true
        }
           else {
            let index = viewedIdList.firstIndex(of: cell.id!)
            viewedIdList.remove(at: index!)
            cell.viewedButton.isSelected = false
        }
        defaults.set(viewedIdList, forKey: "ViewedArray")
        moviesView.moviesTableView.reloadData()

    }
    
    func tapFavouriteButton(cell: MovieTableViewCell) {
        print("Fav Tapped")
        cell.favouriteSelected?.toggle()
        if cell.favouriteSelected == true {
            favoritesIdList.append(cell.id!)
            cell.favouriteButton.isSelected = true
        } else {
            let index = favoritesIdList.firstIndex(of: cell.id!)
            favoritesIdList.remove(at: index!)
            cell.favouriteButton.isSelected = false
        }
        defaults.set(favoritesIdList, forKey: "FavoritesArray")
        moviesView.moviesTableView.reloadData()
    }
    
    func tapCell(cell: MovieTableViewCell) {
        let detailViewController = DetailViewController()
        detailViewController.detailTitle = cell.title!
        MoviesApi.fetchMoviesJsonById(id: cell.id!) { result in
            switch result {
                
            case .success(let json):
                    MoviesApi.downloadImages(url: URL(string: json.poster)!) {
                        resultImage in
                        switch resultImage{
                        case .success(let image):
                            DispatchQueue.main.async {
                                print("Image Dowloaded")
                                detailViewController.detailRate = json.score
                                detailViewController.detailImage = image
                                detailViewController.detailTitle = json.title
                                detailViewController.detailDescription = json.description
                                self.navigationController?.pushViewController(detailViewController, animated: true)
                            }
                        case .failure(_):
                            print("Error Downloading Image")
                        }
                    }
            case .failure(let error):
                print("error")
                print(error)
            }
        }
        
    }
    
    
}
