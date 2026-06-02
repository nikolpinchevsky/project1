import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var player0Label: UILabel!
    @IBOutlet weak var pcLabel: UILabel!
    @IBOutlet weak var pc0Label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var playerCardImageView: UIImageView!
    @IBOutlet weak var pcCardImageView: UIImageView!

    var playerName = "Player"

    var playerScore = 0
    var pcScore = 0
    var round = 0
    var seconds = 5
    var timer: Timer?

    let cards = [
        ("001-ace of spades", 14),
        ("002-ace of clubs", 14),
        ("003-ace of diamonds", 14),
        ("004-ace of hearts", 14),
        ("021-six of spades", 6),
        ("025-seven of spades", 7),
        ("029-eight of spades", 8),
        ("033-nine of spades", 9),
        ("037-ten of spades", 10),
        ("041-jack of spades", 11),
        ("045-queen of spades", 12),
        ("049-king of spades", 13)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        playerLabel.text = playerName
        player0Label.text = "0"
        pcLabel.text = "PC"
        pc0Label.text = "0"
        timerLabel.text = "5"

        startGame()
    }

    func startGame() {

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.seconds -= 1
            self.timerLabel.text = "\(self.seconds)"

            if self.seconds == 0 {
                self.seconds = 5
                self.playRound()
            }
        }
    }

    func playRound() {
        if round >= 10 {
            timer?.invalidate()
            timer = nil
            goToResultScreen()
            return
        }

        round += 1
        seconds = 5
        timerLabel.text = "5"

        var playerCard = cards.randomElement()!
        var pcCard = cards.randomElement()!

        while playerCard.0 == pcCard.0 {
            pcCard = cards.randomElement()!
        }

        playerCardImageView.image = UIImage(named: playerCard.0)
        pcCardImageView.image = UIImage(named: pcCard.0)

        if playerCard.1 > pcCard.1 {
            playerScore += 1
        } else if pcCard.1 > playerCard.1 {
            pcScore += 1
        }

        player0Label.text = "\(playerScore)"
        pc0Label.text = "\(pcScore)"
    }

    func goToResultScreen() {
        timer?.invalidate()
        timer = nil

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController

        if playerScore > pcScore {
            resultVC.winnerText = "Winner: \(playerName)"
            resultVC.scoreText = "score: \(playerScore)"
        } else if pcScore > playerScore {
            resultVC.winnerText = "Winner: PC"
            resultVC.scoreText = "score: \(pcScore)"
        } else {
            resultVC.winnerText = "Winner: PC"
            resultVC.scoreText = "score: \(pcScore)"
        }

        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true)
    }
}
