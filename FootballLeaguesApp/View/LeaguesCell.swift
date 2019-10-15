//
//  LeaguesCell.swift
//  FootballLeaguesApp
//
//  Created by yasmeen on 10/14/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class LeaguesCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //config cell using view model
    func configureCell(league: LeaguesModel) {
        
        
        id.text = league.id!
        name.text = league.name!
        startDate.text = league.start!
        endDate.text = league.end!
       
    }
}
