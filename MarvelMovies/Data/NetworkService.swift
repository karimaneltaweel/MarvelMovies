//
//  NetworkServices.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

protocol NetworkServiceProtocol{
    static func request<T: Codable>(url: String,method: HTTPMethod,view:UIView,callBack:@escaping (T?) -> Void)
}

class NetworkService:NetworkServiceProtocol{
   
    static func request<T: Codable>(url: String,method: HTTPMethod,view:UIView,callBack:@escaping (T?) -> Void) {
        
        let frame = CGRect(x: view.frame.width / 2 , y: view.frame.height / 2, width: 0, height: 0)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                            type: .ballScale)
        activityIndicatorView.color = UIColor.gray
        activityIndicatorView.padding = 100
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        AF.request(url, method: method).response{ (response) in
            if let data = response.data {
                do{
                    activityIndicatorView.stopAnimating()
                    let result = try JSONDecoder().decode(T.self, from: data)
                    callBack(result)
                }
                catch{
                    callBack(nil)
                }
            }
        }
    }
}
