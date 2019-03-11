//
//  DeleteCheckBoxView.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/11.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class DeleteCheckBoxView: UIView {

    static var numberOfCheckedBoxes = 0
    var isChecked = false
    
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBAction func toggleSelection(_ sender: UIButton) {
        if isChecked {
            toggleButton.setImage(UIImage(named: "UnselectedDelete50px"), for: .normal)
            isChecked = false
            DeleteCheckBoxView.numberOfCheckedBoxes -= 1
        } else {
            toggleButton.setImage(UIImage(named: "SelectedDelete50px"), for: .normal)
            isChecked = true
            DeleteCheckBoxView.numberOfCheckedBoxes += 1
        }
    }
    
    static func getNumberMarkedForDelete() -> Int {
        return DeleteCheckBoxView.numberOfCheckedBoxes
    }
    
    static func resetMarkedCounter() {
        DeleteCheckBoxView.numberOfCheckedBoxes = 0
    }
}
