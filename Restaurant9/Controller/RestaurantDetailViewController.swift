//
//  RestaurantDetailViewController.swift
//  Restaurant9
//
//  Created by 李浩綸 on 2018/7/19.
//  Copyright © 2018年 李浩綸. All rights reserved.
//

import UIKit
import MapKit
//var globalRestaurant:Restaurant!寫在這理代表是全部APP內都可以使用這功能太強大了
var globalRestaurant:Restaurant!


class RestaurantDetailViewController: UIViewController {
    //有需要再來使用weak會比較好
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet var mapView:MKMapView!
    
    
    var restaurant:Restaurant!
  
    static var typeRestaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        globalRestaurant = restaurant
        RestaurantDetailViewController.typeRestaurant = restaurant
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        
        /*
        //建立UITapGestureRecognizer來帶入Map
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
         //使用storyboard
     */
        
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
                self.mapView.addAnnotation(annotation)
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
    //手動語法的話要讓objectiveC知道有showMap所以要使用@objc
    //如果要用storyboard建立的話要先改成@IBAction然後要利用storyboard拉一個gesture的到MKMapView裡面然後拉建立的Segue的identifiy的showMap至剛剛拉的gesture
    @IBAction func showMap(){
        performSegue(withIdentifier: "showMap", sender: self)
    }
    
    
    
    //viewWillAppear是每次都會把隱藏的叫出來做使用的功能
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hidesBarsOnSwipe
        //這段是修改navigation上面的Bar
        navigationController?.hidesBarsOnSwipe = false
        //setNavigationBarHidden(false, animated: true)如果隱藏還是會被叫出來
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //這段在修改Segue的identifier功能
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goReview"{
            let reviewViewController = segue.destination as! ReviewViewController
            reviewViewController.restaurant = restaurant
        }else if segue.identifier == "showMap"{
            let mapViewController = segue.destination as! MapViewController
            mapViewController.restaurant = restaurant
        }
    }
    
    
    //設定離開指令
    @IBAction func close(_ sender:UIStoryboardSegue){
        
    }
    
    //先設定unwindsegue再來設定這裡內容
    @IBAction func ratingButtonTapped(segue:UIStoryboardSegue){
        restaurant.isVisited = true
        switch segue.identifier! {
        case "great":
            restaurant.rating = "Absolutely love it! Must try."
        case "good":
            restaurant.rating = "Pretty good"
        case "dislike":
            restaurant.rating = "I don't like it"
        default:break
        }
        //全部跑完後要從新抓一次資料
        tableView.reloadData()
        
    }
    
}

//採納UITableViewDataSource的Protocol
extension RestaurantDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! RestaurantDetailTableVeiwCell
        cell.backgroundColor = UIColor.clear
        
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Visited"
            cell.valueLabel.text = restaurant.isVisited ? "YES, I've been here before. \(restaurant.rating)" : "NO"
        //三元運算式上面這行
        default:break
        }
        return cell
    }
}
