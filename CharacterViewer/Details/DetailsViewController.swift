//
//  DetailsViewController.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/15/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    let viewModel = DetailsViewModel()
    
    @IBOutlet weak var characterImage: UIImageView!
    var character: Character? {
        didSet {
            refershUI()
        }
    }
    
    func refershUI() {
        loadViewIfNeeded()
        titleLabel.text = viewModel.getCharacterName(from: character?.text ?? "")
        characterDescription.text = viewModel.getCharacterDescription(from: character?.text ?? "")
        
        // Set the image
        if let imageURLString = character?.imageURLString, imageURLString != ""  {
            characterImage.kf.setImage(with: URL(string: imageURLString))
        } else {
            // Used free place holder image https://pixabay.com/vectors/avatar-icon-placeholder-1577909/
            characterImage.image = UIImage(named: "Character-Placeholder")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CharacterDetailsViewController: CellSelectionDelegate {
    func cellSelected(with data: Character?) {
        character = data
    }
}
