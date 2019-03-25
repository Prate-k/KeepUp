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
    func loadImageFromSource(source: String) {
        let imgSource = "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/56x56-000000-80-0-0.jpg"
        Alamofire.download(imgSource).responseData { response in
            Alamofire.request(imgSource, method: .get)
                .validate()
                .responseData(completionHandler: { (responseData) in
                    DispatchQueue.main.async {
                        self.image = UIImage(data: responseData.data!)
                    }
                })
        }
    }
}
