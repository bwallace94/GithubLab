//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Bria Wallace on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class RepoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numberStarsLabel: UILabel!
    @IBOutlet weak var numberForksLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var repo: GithubRepo! {
        didSet {
            if let name = repo.name {
                nameLabel.text = name
            }
            if let author = repo.ownerHandle {
                authorLabel.text = author
            }
            if let stars = repo.stars {
                numberStarsLabel.text = "\(stars)"
            }
            if let forks = repo.forks {
                numberForksLabel.text = "\(forks)"
            }
            if let description = repo.repoDescription {
                descriptionLabel.text = description
                descriptionLabel.sizeToFit()
            }
            if let avatarImageString = repo.ownerAvatarURL {
                let avatarImageURL = URL(string: avatarImageString)
                avatarImageView.setImageWith(avatarImageURL!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
