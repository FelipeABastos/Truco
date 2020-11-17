//
//  CardCell.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import UIKit
import SDWebImage

class CardCell: UICollectionViewCell {
    @IBOutlet var imgCard: UIImageView?
    
    func loadUI(item: Card) {
        imgCard?.sd_setImage(with: URL(string: item.image ?? ""))
    }
}
