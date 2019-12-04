//
//  JediTableViewCell.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/4/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import UIKit



class JediTableViewCell: UITableViewCell {
    
    let jediVM = JediViewModel.shared
    
    @IBOutlet weak var jediNameLabel: UILabel!
    @IBOutlet weak var jediImageView: UIImageView!
    
    var result: Result? {
        didSet {
            jediImageView.image = .nonSelected
            guard let result = result else { return }
            jediNameLabel.text = result.name
            
            guard let id = result.created else { return }
            if let _ = jediVM.savedResults[id] {
                // This is already saved
                jediImageView.image = .selected
            } else {
                jediImageView.image = .nonSelected
            }
        }
    }
    
}
