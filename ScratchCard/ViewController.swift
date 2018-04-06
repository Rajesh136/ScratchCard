//
//  ViewController.swift
//  ScratchCard
//
//  Created by techno krishna on 06/04/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scratchCard:ScratchCard!
    override func viewDidLoad() {
        super.viewDidLoad()
        scratchCard = ScratchCard(frame: view.frame)
        view.addSubview(scratchCard)
      
    }

    


}

