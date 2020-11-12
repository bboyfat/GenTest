//
//  RepoCell.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var repoName: UILabel!
    @IBOutlet var repoUrl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.circleRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RepoCell {
    func set(_ item: Items) {
        avatar.loadImage(path: item.owner.avatar_url)
        repoName.text = item.name
        repoUrl.text = item.html_url
    }
}

