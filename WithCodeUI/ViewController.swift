//
//  ViewController.swift
//  WithCodeUI
//
//  Created by hideto c. on 2021/05/06.
//

import UIKit

struct Player {
    let pogision: String
    let name: String
    var image: UIImage?
}

class ViewController: UIViewController {
    
    private let cellId = "cellId"
    private let players: [Player] = [
        .init(pogision: "ポジション", name: "サッカーボール", image: UIImage(named: "サッカーボール"))
    ]
    
    lazy var playerTableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SOCCER"
        view.backgroundColor = .red
        view.addSubview(playerTableView)
        playerTableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: cellId)
        
//        playerTableView.frame = view.frame
        [playerTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
         playerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
         playerTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
         playerTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ].forEach{ $0.isActive = true }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlayerTableViewCell
        cell.player = players[indexPath.row]
        
        return cell
    }

}

class PlayerTableViewCell: UITableViewCell {
    
    var player: Player? {
        didSet {
            if let image = player?.image {
                playerImageView.image = image
            }
            nameLabel.text = player?.name
            pogisionLabel.text = player?.pogision
        }
    }
    
    private let playerImageViewHeight: CGFloat = 60
    
    lazy var playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = playerImageViewHeight / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "名前"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pogisionLabel: UILabel = {
        let label = UILabel()
        label.text = "ポジジョン"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(playerImageView)
        addSubview(nameLabel)
        addSubview(pogisionLabel)
        
        [playerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         playerImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         playerImageView.widthAnchor.constraint(equalToConstant: playerImageViewHeight),
         playerImageView.heightAnchor.constraint(equalToConstant: playerImageViewHeight),
         
         nameLabel.leftAnchor.constraint(equalTo: playerImageView.rightAnchor, constant: 24),
         nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
         
         pogisionLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 32),
         pogisionLabel.leftAnchor.constraint(equalTo: playerImageView.rightAnchor, constant: 24)
         
        ].forEach{ $0.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
