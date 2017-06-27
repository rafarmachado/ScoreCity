//
//  CitiesTableViewCell.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    
    //MARK: - Lifecicle and method
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }
}
