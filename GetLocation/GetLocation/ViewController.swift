//
//  ViewController.swift
//  GetLocation
//
//  Created by Jinzhou Yan on 3/13/22.
//

import UIKit
import CoreLocation//2.引入系统框架：CoreLocation.framework

/*
 1. privacy info:
 
 Privacy - Location When In Use Usage Description
 Privacy - Location Always Usage Description
 Privacy - Location Usage Description
 Privacy - Location Always and When In Use Usage Description
 
 2. import CoreLocaion
 
 3. create outlets and CLLocationManagerDelegate
 
 4. create a locationManager isntance
 
 5. viewdidload set delegate, request usage and accuracy
 
 6. add didUpdateLocations function for locationManger this function will be called when any location change happens.
    Or request is made for location and write the didFailWithError function
 
 7. when get location just once you'll add that in a button and cell locationManger.reuqestLocation()
 
 8. when get location change in the background and monitor changes you will make
 
 
 */

class ViewController: UIViewController, CLLocationManagerDelegate {//3.CLLocationManagerDelegate
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    let locationManager = CLLocationManager()//4.调用CLLocationManager
    
    override func viewDidLoad() {//5. viewdidload需要的视图元素都在此方法加载
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        startSignificantLocationChange()//如果有重大位置变化，则更新位置
        
    }
    @IBAction func getLocationAction(_ sender: Any) {//按键调用经纬度
        locationManager.requestLocation()//7. CLLocationManager中自带的函数
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){//6. locationManager的catch:didFailWithError
        print("Error in getting location \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){//6.locationManager获取经纬:didUpdateLocations
        guard let location = locations.last else { return }
        
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        
        print(lat)
        print(lng)
        
        lblLatitude.text = "\(lat)"
        lblLongitude.text = "\(lng)"
        
        getAddress(location: location)//处理最后一个地理位置数据，并将其处理
        
    }
    
    func startSignificantLocationChange(){
        if CLLocationManager.significantLocationChangeMonitoringAvailable(){//8. 如果有显著地理位置变化，更新位置
            locationManager.startMonitoringSignificantLocationChanges()//检测有无显著位置变化
            locationManager.startUpdatingLocation()//更新地理位置
        }
    }
    
    func getAddress(location: CLLocation){//获取位置（输入经纬度，输出位置）
        let clGeocoder = CLGeocoder() //调用CLGeocoder
        clGeocoder.reverseGeocodeLocation(location){ placeMarks, error in
            if error != nil {
                self.lblAddress.text = "Unable to get Address"//catch
                return
            }
            
            guard let place = placeMarks?[0] else {return}
            
            var address = ""//记录处理的信息
            //如果有某个信息，就存储在address字符串中
            if place.name != nil {
                address += place.name! + ", "
            }
            if place.locality != nil {
                address += place.locality! + ", "
            }
            if place.subLocality != nil {
                address += place.subLocality! + ", "
            }
            if place.postalCode != nil {
                address += place.postalCode! + ", "
            }
            if place.country != nil {
                address += place.country! + ", "
            }
            
            print(address)
            self.lblAddress.text = address//显示到用户界面中
        }
    }
}

