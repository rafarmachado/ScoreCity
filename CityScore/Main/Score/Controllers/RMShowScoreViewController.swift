//
//  RMShowScoreViewController.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 27/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit

class RMShowScoreViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newSearchButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var rankingImageView: UIImageView!
    
    //MARK: - Variables
    var score: ScoreModel! = ScoreModel()
    
    //MARK: - Lifecicle and Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Personalize View
        self.personalizeView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // PrepareView 
        prepareScore()
        
    }
    
    //MARK: - Prepare Score
    func prepareScore(){
        self.cityNameLabel.text = "A pontuação da cidade de \(score.cityName!) é de:"
        self.scoreLabel.text = score.cityScore
        
    }
    
    //MARK: - Personalize VIew
    func personalizeView(){
        //View
        view.backgroundColor = UIColor.darkGray
        
        //ContainerView
        self.containerView.layer.cornerRadius = 6
        self.containerView.clipsToBounds = true
        
        //Image View
        rankingImageView.layer.cornerRadius = 8
        rankingImageView.clipsToBounds = true
        rankingImageView.tintColor = UIColor.white
        rankingImageView.backgroundColor = UIColor.init(hex: "4B998C")

    }
    
    //MARK: - Actions
    
    @IBAction func performBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }

    @IBAction func performNewSearch(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        
    }
}
