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
    
    let gradient = CAGradientLayer()
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientColor = gradientColor()
        gradientColor.frame = backgroundView.bounds
        backgroundView.layer.insertSublayer(gradientColor, at: 0)
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

extension MarvelFilmsViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvalFilmTableViewCell", for: indexPath) as! MarvalFilmTableViewCell
        
        viewCorner(view: cell.mainView,borderColor: UIColor.lightGray.cgColor)
        
        if indexPath.row == index {
            cell.filmExpendedView.isHidden = false
        }else{
            cell.filmExpendedView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        tableView.reloadData()

    }
    
    
}
