//
//  RMSearchCityStateViewController.swift
//  CityScore
//
//  Created by Rafael Rezende Machado on 26/06/17.
//  Copyright © 2017 RafaelRezendeMachado. All rights reserved.
//

import UIKit

class RMSearchCityStateViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var doubtsButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    //MARK: - Variables
    var keyboardSizeControl = CGFloat(0)
    var viewIsMoved = false
    var arrayCitiesState: [CityStateModel] = []
    var filteredArray: [CityStateModel] = []
    let cityStateService = CitySearchServices()
    var activityIndicator = ActivityIndicatorUtil()
    var nameCity: String!
    var nameState: String!
    var segueResult = "searchResultSegue"
    
    
    //MARK: - Lifecicle and Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize view and initialize view
        self.personalizeView()
        self.initializeViewComponents()
        
        //Keyboard Notification
        self.registerForKeyboardNotification()
        
        //Activity Indicator
        activityIndicator = ActivityIndicatorUtil(view: self.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if filteredArray.count > 0{
            filteredArray.removeAll()
            
        }
    }
    
    //MARK: - Customize View
    func personalizeView(){
        //NavigationBar
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
        //View
        view.backgroundColor = UIColor.darkGray
        
        //ContainerView
        self.containerView.layer.cornerRadius = 6
        self.containerView.clipsToBounds = true
        
        //ImageIcon
        iconImageView.layer.cornerRadius = 8
        iconImageView.clipsToBounds = true
        
    }
    
    func initializeViewComponents(){
        self.alertView.isHidden = true
        
    }
    
    //MARK: - TextField Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        alertView.isHidden = true
        
    }
    
    // MARK: - Keyboard Methods
    func registerForKeyboardNotification(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RMSearchCityStateViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RMSearchCityStateViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RMSearchCityStateViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.containerView.translatesAutoresizingMaskIntoConstraints = true
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !viewIsMoved{
                self.containerView.frame.origin.y -= keyboardSize.height
                viewIsMoved = true
            }else{
                self.containerView.frame.origin.y -= keyboardSize.height - keyboardSizeControl
            }
            keyboardSizeControl = keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        if viewIsMoved{
            self.containerView.frame.origin.y += keyboardSizeControl
            viewIsMoved = false
        }
        
    }
    
    //MARK: - Validations
    func validFields() -> Bool{
        var validField: Bool = false
        
        if cityTextField.text != nil && cityTextField.text != nil && cityTextField.text != "" && stateTextField.text != ""{
            if (cityTextField.text?.characters.count)! > 3 && (cityTextField.text?.characters.count)! > 3{
                validField = true
            }else{
                alertView.isHidden = false
                alertLabel.text = StringsUtil.getString("MORE_INFORMATIONS")
            }
        }else{
            alertView.isHidden = false
            alertLabel.text = StringsUtil.getString("INVALID_FIELDS")
            
        }
        
        return validField
        
    }
    
    //MARK: - Services and Request
    func mountSearch(){
        nameCity = cityTextField.text
        nameState = stateTextField.text
        loadDataSourceCities()
        
    }
    
    func loadDataSourceCities(){
        self.activityIndicator.showActivityIndicator()
        cityStateService.getCities(success: {(result: Any?) -> Void in
            if let cities = result as? [CityStateModel] {
                self.arrayCitiesState = cities
                self.filtreArray()
            }else{
                self.activityIndicator.hideActivityIndicator()
                AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: StringsUtil.getString("UNEXPECTED_ERROR"), view: self)
            }
        }, failure: {(error: Any?) -> Void in
            
            if let errorMessage = error as? String{
                self.activityIndicator.hideActivityIndicator()
                AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: errorMessage, view: self)
                
            }else{
                self.activityIndicator.hideActivityIndicator()
                AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: StringsUtil.getString("UNEXPECTED_ERROR"), view: self)
            }
            
        }, complete: {() -> Void in
            
        })
        
    }
    
    //MARK: - Filtre Array
    func filtreArray(){
        var auxState: String! = ""
        var auxCity: String! = ""
        
        let state = nameState.folding(options: .diacriticInsensitive, locale: .current).lowercased().replacingOccurrences(of: " ", with: "")
        let city = nameCity.folding(options: .diacriticInsensitive, locale: .current).lowercased().replacingOccurrences(of: " ", with: "")
        
        for elements in arrayCitiesState{
            auxState = elements.stateSearched.folding(options: .diacriticInsensitive, locale: .current).lowercased().replacingOccurrences(of: " ", with: "")
            auxCity = elements.citySearched.folding(options: .diacriticInsensitive, locale: .current).lowercased().replacingOccurrences(of: " ", with: "")
            if auxState.contains(state){
                if auxCity.contains(city) {
                    filteredArray.append(elements)
                }
            }
        }
        
        self.activityIndicator.hideActivityIndicator()
        if filteredArray.count > 0{
            self.goToResult(cities: filteredArray)
        }else{
            AlertUtil.ShowAlertMessage(title: StringsUtil.getString("ERROR"), message: StringsUtil.getString("NOT_FOUND"), view: self)
        }
        
    }
    
    //MARK: - Navigations Methods
    func goToResult(cities: [CityStateModel]){
        performSegue(withIdentifier: segueResult, sender: cities)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueResult {
            if let results = segue.destination as? RMSearchResultViewController {
                results.arrayCities = sender as! [CityStateModel]
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func performShowClarification(_ sender: Any) {
        AlertUtil.ShowAlertMessage(title: StringsUtil.getString("QUESTION"), message: StringsUtil.getString("TUTORIAL"), view: self)
        
    }
    
    @IBAction func performSearchCities(_ sender: Any) {
        if validFields(){
            mountSearch()
        }
    }
    
}
