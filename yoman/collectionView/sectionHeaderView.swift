//
//  sectionHeaderView.swift
//  yoman
//
//  Created by רותם שיין on 21/12/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit

class sectionHeaderView: UICollectionReusableView
{
    @IBOutlet weak var dateLabel: UILabel!
    
    var categoryDate : String!{
        didSet{
            dateLabel.text = categoryDate
        }
    }
}
