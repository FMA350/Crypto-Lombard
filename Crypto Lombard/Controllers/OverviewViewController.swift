//
//  ViewController.swift
//  Crypto Lombard
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 15/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentCryptoCurrency: Int = 0 //bitcoin
    var currentFiatCurrency : Int = 0 //dollars
    let currencyLogo : UIImageView = {
        let image : UIImage = UIImage(named: "bitcoin")!
        //TODO: unwrap and remove force unwrap
        let imageView : UIImageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let financialProductNameLabel : UILabel = {
        let uilabel : UILabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false

        return uilabel
    }()
    
    let financialProductValueLabel : UILabel = {
        let uilabel : UILabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    //TODO: add graph
    
    let currencyPicker : UIPickerView = {
        let picker : UIPickerView = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let toMyPortfolioButton : UIButton = {
        let button : UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My portfolio", for: .normal)
        button.setTitleColor(.green, for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrencies()
        setFinancialProducts()
        addSubviews()
        setupLayoutConstraint()
        setupProperties()
        addGestures()
        updateScreenView()

    }
    
    func addGestures(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func setupLayoutConstraint(){
        let y = UIScreen.main.bounds.height
        //constrains top to bottom
        currencyLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currencyLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        currencyLogo.heightAnchor.constraint(equalToConstant: y*0.1).isActive = true
        currencyLogo.widthAnchor.constraint(equalTo: currencyLogo.heightAnchor).isActive = true
        
        financialProductNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        financialProductNameLabel.topAnchor.constraint(equalTo: currencyLogo.bottomAnchor, constant: 20).isActive = true

        financialProductValueLabel.topAnchor.constraint(equalTo: financialProductNameLabel.bottomAnchor, constant: 50).isActive = true
        financialProductValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        currencyPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currencyPicker.bottomAnchor.constraint(equalTo: toMyPortfolioButton.topAnchor, constant: 5).isActive = true
        
        toMyPortfolioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toMyPortfolioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
    }
    
    func setupProperties(){
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        self.view.backgroundColor = .overviewBackground
    }
    
    func addSubviews(){
        self.view.addSubview(currencyLogo)
        self.view.addSubview(financialProductNameLabel)
        self.view.addSubview(financialProductValueLabel)
        self.view.addSubview(currencyPicker)
        self.view.addSubview(toMyPortfolioButton)
    }
    
    func changeCurrentCryptoCurrency(value : Int){
        if currentCryptoCurrency + value >= 0 && currentCryptoCurrency + value < financialProduct.count{
            currentCryptoCurrency += value
            updateScreenView()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fiatCurrency[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fiatCurrency.count
    }
    
    func updateScreenView(){
        financialProduct[currentCryptoCurrency].updateData(){
            (results) in
            let price = financialProduct[self.currentCryptoCurrency].data[self.currentFiatCurrency]["last"].stringValue
            self.financialProductValueLabel.text = "Last traded price: \(price)"
            let img = financialProduct[self.currentCryptoCurrency].getImageName()
            if let image : UIImage = UIImage(named: img ){
                self.currencyLogo.image = image
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update the financial product value text
        currentFiatCurrency = row
        updateScreenView()
    }
    
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.direction == .right{
            if gestureRecognizer.state == .ended {
                changeCurrentCryptoCurrency(value: -1)
            }
        }
        if gestureRecognizer.direction == .left{
            if gestureRecognizer.state == .ended {
                changeCurrentCryptoCurrency(value: 1)
            }
        }
    }
}


