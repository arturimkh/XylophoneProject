

import UIKit
import AVFoundation
class ViewController: UIViewController {
    let stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    var player: AVAudioPlayer!
    func playSound(_ title: String) {
        guard let url = Bundle.main.url(forResource: title, withExtension: "wav") else { return }
      player = try! AVAudioPlayer(contentsOf: url)
      player.play()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        makeButtons()
    }
    
    func makeButtons(){
        let buttons = ["C", "D", "E", "F", "G", "A", "B"]
        let width = UIScreen.main.bounds.width
        for i in buttons.indices{
            let label = buttons[i]
            let button: UIButton = {
                let button  = UIButton()
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
                button.backgroundColor = UIColor.init(named: label)
                button.setTitle(label, for: .normal)
                button.layer.cornerRadius = 10
                button.translatesAutoresizingMaskIntoConstraints = false
                button.widthAnchor.constraint(equalToConstant: width * (1 - CGFloat(i + 3) * 0.035)).isActive = true
                return button
            }()
            button.addTarget(self, action: #selector(keyPressed), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
    }
    
    @objc func keyPressed(_ sender: UIButton) {
      if let title = sender.currentTitle { playSound(title)}
    }
}

extension ViewController {
    func setupConstraints(){
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ])
    }
}
