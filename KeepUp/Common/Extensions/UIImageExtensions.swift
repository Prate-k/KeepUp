//
//  UIImageExtensions.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/05.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func loadImageFromSource(source: String, tableView: UITableView) {
        Alamofire.download(source).responseData { _ in
            Alamofire.request(source, method: .get)
                .validate()
                .responseData(completionHandler: { (responseData) in
                    DispatchQueue.main.async {
                        if let respData = responseData.data {
                            self.image = UIImage(data: respData)
                            tableView.reloadData()
                        }
                    }
                })
        }
    }
    
    func loadImageFromSource(source: String) {
        Alamofire.download(source).responseData { _ in
            Alamofire.request(source, method: .get)
                .validate()
                .responseData(completionHandler: { (responseData) in
                    DispatchQueue.main.async {
                        if let respData = responseData.data {
                            self.image = UIImage(data: respData)
                        }
                    }
                })
        }
    }
}
