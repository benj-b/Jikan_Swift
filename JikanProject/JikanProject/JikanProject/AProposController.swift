//
//  AProposController.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import UIKit

class AProposController: UIViewController {
    
    @IBOutlet var Pagetitle: UILabel?
    @IBOutlet var img: UIImageView?
    @IBOutlet var bottomText: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Pagetitle?.text = "A propos de l'application"
        img?.image = UIImage(named: "jikan")
        bottomText?.text = "Made by : \n\n Yahya Aarji \n Ayoub Admessiev \n Benjamin Bernaud \n\n 2023"
    }
}
