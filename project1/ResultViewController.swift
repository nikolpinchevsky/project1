//
//  ResultViewController.swift
//  project1
//
//  Created by Sean on 01/06/2026.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    var winnerText = ""
    var scoreText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        winnerLabel.text = winnerText
        scoreLabel.text = scoreText
    }

    @IBAction func backToMenuTapped(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}
