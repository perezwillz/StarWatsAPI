//
//  JediDetailViewController.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/3/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import UIKit

class JediDetailViewController: UIViewController {
    
    let jediVM = JediViewModel.shared
    weak var delegate : JediTableCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupViews()
    }
    
    // Elements
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var biGenderLabel: UILabel!
    
    // PropertyObserver
    var result: Result? {
        didSet {
            guard isViewLoaded else { return }
            updateViews()
        }
    }
}

// PrivateExtension
private extension JediDetailViewController {
    func updateViews(){
        guard let result = result else { return }
        nameLabel.text = "Name: \(result.name?.capitalized ?? "No Name")"
        heightLabel.text = "Height: \(result.height ?? "No Height")"
        massLabel.text = "Weight : \(result.mass ?? "No Mass")"
        skinColorLabel.text = "Skin Color: \(result.skin_color?.capitalized ?? "No Skin Color")"
        eyeColorLabel.text = "Eye Color: \(result.eye_color?.capitalized ?? "No Eye Color")"
        birthYearLabel.text = "Birth Year: \(result.birth_year ?? "No Birth Year")"
        biGenderLabel.text = "Gender: \(result.gender?.capitalized ?? "NO Gender")"
        
        guard let id = result.created else { return }
        if let _ = jediVM.savedResults[id] {
            // This is already saved
            selectImage.image = .selected
        } else {
            selectImage.image = .nonSelected
        }
    }
    
    func setupViews(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        selectImage.isUserInteractionEnabled = true
        selectImage.addGestureRecognizer(tap)
    }
    
    func toggleImageAndSave(){
        guard let result = result else {
            return
        }
        
        switch selectImage.image {
        case UIImage.nonSelected :
            // Not Selected
            jediVM.saveResult(result: result)
            selectImage.image = .selected
        case UIImage.selected:
            // Selected
            jediVM.deleteResult(result: result)
            selectImage.image = .nonSelected
        default:
            return
        }
        delegate?.toggleHasBeenRead(for: self)
    }
}

@objc extension JediDetailViewController {
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        toggleImageAndSave()
    }
}
