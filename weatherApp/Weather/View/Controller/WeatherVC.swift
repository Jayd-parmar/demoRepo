//
//  WeatherVC.swift
//  weatherApp
//
//  Created by Jaydip Parmar on 25/09/23.
//

import UIKit

class WeatherVC: UIViewController {
    
    //MARK: - Variables
    let weatherModel = WeatherViewModel()
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var searchCity: UITextField!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    var isError: Bool = false
    
    @IBAction func EnterButtonTapped(_ sender: UIButton) {
        APIManager.searchCity = searchCity.text!
        initViewModel()
        searchCity.text = ""
    }
    
    //MARK: -View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColorUI()
        configuration()
    }
    
    func setupBackgroundColorUI() {
        view.backgroundColor = .systemGray6
        btnEnter.layer.cornerRadius = 8
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configuration() {
        observeEvent()
    }
    
    func initViewModel() {
        weatherModel.getWeatherData()
    }
    
    func observeEvent() {
        weatherModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("loading....")
            case .stopLoading:
                print("stop loading...")
            case .dataLoaded:
                print("data loaded")
                isError = false
                isErrorCame()
                DispatchQueue.main.async {
                    self.configureWeatherDetails()
                }
            case .error(_):
                isError = true
                isErrorCame()
            }
        }
        
    }
    
    func configureWeatherDetails() {
        guard let weather = weatherModel.weatherData else { return }
        
        lblCity.text = "\((weather.name)), \((weather.sys.country))"
        lblTemp.text = "\((weather.main.temp - 273).rounded()) °C"
        lblDesc.text = "Feels like \((weather.main.feels_like! - 273).rounded()) °C \(weather.weather[0].main), \(weather.weather[0].description)"
        imgWeather.setImage(with: "\(Constant.URL.weatherImageUrl)\(weather.weather[0].icon)@2x.png")
    }
    
    func isErrorCame() {
        DispatchQueue.main.async {
            self.lblCity.isHidden = self.isError
            self.lblTemp.isHidden = self.isError
            self.lblDesc.isHidden = self.isError
            self.imgWeather.isHidden = self.isError
            if !self.isError {
                self.showToast(message: "Weather details of city you searched", font: .systemFont(ofSize: 12.0))
            } else {
                self.showToast(message: "Please recheck the city you entered", font: .systemFont(ofSize: 12.0))
            }
        }
    }
}

extension WeatherVC {

    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
