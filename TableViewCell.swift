//
//  TableViewCell.swift
//  PracticaFutbol
//
//  Created by Javier on 22/12/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imagen1: UIImageView!
    @IBOutlet weak var imagen2: UIImageView!
    @IBOutlet weak var nombre1: UILabel!
    @IBOutlet weak var nombre2: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var liga: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var fecha2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }

}
