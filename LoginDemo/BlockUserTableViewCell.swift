//
//  BlockUserTableViewCell.swift
//  LoginDemo
//
//  Created by Tien Le on 7/26/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit

class BlockUserTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var btnUnBlock: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
