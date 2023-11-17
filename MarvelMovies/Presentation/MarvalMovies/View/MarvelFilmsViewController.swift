//
//  MarvelFilmsViewController.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 16/11/2023.
//

import UIKit

class MarvelFilmsViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var searchView: UIView!{
        didSet{
            viewCorner(view: searchView,borderColor: UIColor.red.cgColor)
        }
    }
    @IBOutlet weak var searchField: UITextField!{
        didSet{
            setupSearchBarView()
        }
    }
    @IBOutlet weak var filmsTable: UITableView!
    
    let gradient = CAGradientLayer()
    var index: Int?
    var offsetNo: Int = 0
    var FilmsViewModel : MarvalMoviesViewModelProtocol = MarvalMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientColor = gradientColor()
        gradientColor.frame = backgroundView.bounds
        backgroundView.layer.insertSublayer(gradientColor, at: 0)
        offsetNo = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FilmsViewModel.getFilms(view: self.view,limit: 15 ,offestNum: offsetNo)
        FilmsViewModel.MarvelFilmsBinding = {
            DispatchQueue.main.async{ [weak self] in
                self?.filmsTable.reloadData()
            }
        }
        
    }
    
    @IBAction func SearchAction(_ sender: UITextField) {
        FilmsViewModel.SearchForFilm(seaechWord: sender.text ?? "")
    }
    
    func viewCorner(view:UIView,borderColor:CGColor){
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor
        view.clipsToBounds = true
    }
    
    private func setupSearchBarView() {
        searchField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x:0, y: 0, width: 50, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = .red
        searchField.leftView = imageView
        searchField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1215686426, green: 0.1215686426, blue: 0.1215686426, alpha: 1)])
    }
    
    func gradientColor() -> CAGradientLayer{
        gradient.colors = [UIColor.black.cgColor,UIColor.gray.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0,y: 1)
        return gradient
    }
    
}
