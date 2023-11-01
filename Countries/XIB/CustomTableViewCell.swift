//
//  CustomTableViewCell.swift
//  Countries
//
//  Created by Omar Hesham on 9/18/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(countriesInfo: CountriesModel?) {
        nameLabel.text = "\(countriesInfo?.name ?? "Unknown"), \(countriesInfo?.region ?? "Unknown")"
        codeLabel.text = countriesInfo?.code ?? "Unknown"
        capitalLabel.text = countriesInfo?.capital ?? "Unknown"
    }
    
}
