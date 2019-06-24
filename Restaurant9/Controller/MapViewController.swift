//
//  MapViewController.swift
//  Restaurant9
//
//  Created by 李浩綸 on 2018/8/7.
//  Copyright © 2018年 李浩綸. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //要用MKMapView這個就一定要import MapKit
    @IBOutlet weak var mapView:MKMapView!
    var restaurant:Restaurant!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
//        mapView.showsTraffic = true
//        mapView.showsScale = true
//        mapView.showsCompass = true
       // print(globalRestaurant.location)
//        print(RestaurantDetailViewController.typeRestaurant.location)
//        print(restaurant.location)
        
        //取得緯經度座標
        //CLGeocoder()是為了帶出緯經度座標用
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
        //這裡可以一樣是因為後面被判定為參數前面被判定為區域變數
        //if let placemarks = placemarks
        if let placemarks = placemarks, let placemark = placemarks.first {
            print("有\(placemarks.count)個轉換地址")
            let coordinate = placemark.location?.coordinate
            
            //mapview有annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!
//            self.mapView.addAnnotation(annotation)
            
            //加上title的name和type
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.type
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
            print(placemark)
            
            //set the zoom level
            //zoom就是放大縮小
            let region = MKCoordinateRegion(center: coordinate!, latitudinalMeters: 250, longitudinalMeters: 250)
            self.mapView.setRegion(region, animated: false)
            
            
        }else{
            print("沒有這個地址")
        }
        
        
    }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//要使用MKAnnotation就必須使用mapView必須採納protocol的methed
extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        //以前Cell的模式是用這個方法去寫的
        let identifier = "myPin"
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        //改變地標針頭的顏色
        annotationView?.pinTintColor = UIColor.orange
        
        
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: restaurant.image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        return annotationView
    }
}
