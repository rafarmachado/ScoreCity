//
//  RMSearchResultViewController.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit

class RMSearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: - Variables
    var arrayCities = [CityStateModel]()
    var cityForSearchScore: CityStateModel = CityStateModel()
    let scoreService = ScoreFromCityServices()
    var activityIndicator = ActivityIndicatorUtil()
    var scoreModel: ScoreModel! = ScoreModel()
    let segueScore = "segueShowScore"

    //MARK: - Lifecile and Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prepare View
        personalizeView()
        //Register Cell
        registerCell()
        //Activity Indicator
        activityIndicator = ActivityIndicatorUtil(view: self.view)

    }
    
    //MARK: -Personalize View
    func personalizeView(){
        //tableView
        self.tableView.layer.cornerRadius = 6
        self.tableView.clipsToBounds = true
        
        //backButton
        backButton.imageView?.tintColor = UIColor.white
        
        //View
        view.backgroundColor = UIColor.darkGray
        
    }
    
    //MARK: - Action
    @IBAction func performBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Register Cell
    func registerCell(){
        self.tableView.register(UINib(nibName: "CitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "CitiesTableViewCell")

    }
    
    //MARK: - Services and Request
    func createRequest(cityName: String, stateName: String){
        cityForSearchScore.citySearched = cityName
        scoreModel.cityName = cityName
        cityForSearchScore.stateSearched = stateName
        getScoreService()
    }
    
    func getScoreService(){
        scoreService.scoreFromCity(city: cityForSearchScore, success: {(result: Any?) -> Void in
            if let scoreResult = result as? String{
                self.scoreModel.cityScore = scoreResult
                self.goToShowScore()
            }else{
                AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: StringsUtil.getString("UNEXPECTED_ERROR"), view: self)
            }
            
        }, failure: {(dataError: Any?) -> Void in
            if let messageError = dataError as? String{
                AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: messageError, view: self)
            }else{
                AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: StringsUtil.getString("UNEXPECTED_ERROR"), view: self)
            }
            
        }, complete: {() -> Void in
            self.activityIndicator.hideActivityIndicator()
            
        })
        

    }
    
    //MARK: - Navigations
    func goToShowScore(){
        performSegue(withIdentifier: segueScore, sender: scoreModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueScore {
            if let results = segue.destination as? RMShowScoreViewController {
                results.score = sender as! ScoreModel
            }
        }

    }

    //MARK: - TableView Delegates and DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayCities.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CitiesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell", for: indexPath) as! CitiesTableViewCell
        let city = arrayCities[indexPath.row]
        cell.cityLabel.text = city.citySearched
        cell.stateLabel.text = city.stateSearched
        cell.iconImageView.tintColor = UIColor.init(hex: "4B998C")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = arrayCities[indexPath.row]
        createRequest(cityName: selectedCity.citySearched, stateName: selectedCity.stateSearched)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }

}
