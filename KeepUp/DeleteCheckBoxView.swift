//
//  DeleteCheckBoxView.swift
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/11.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import UIKit

class DeleteCheckBoxView: UIView {
    
    var isChecked = false
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBAction func toggleSelection(_ sender: Any) {
        toggleCheck()
    }
    
    func toggleCheck() {
        if isChecked {
            toggleButton.setImage(UIImage(named: "UnselectedDelete50px"), for: .normal)
            isChecked = false
        } else {
            if !isChecked {
                toggleButton.setImage(UIImage(named: "SelectedDelete50px"), for: .normal)
                isChecked = true
            }
        }
    }
}
