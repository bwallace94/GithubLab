//
//  LanguageCell.swift
//  GithubDemo
//
//  Created by Bria Wallace on 4/6/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    
    @IBOutlet weak var languageLabel: UILabel!
    
    var language: String! {
        didSet {
            languageLabel.text = language
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
