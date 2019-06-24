 //
//  ReviewViewController.swift
//  Restaurant9
//
//  Created by 李浩綸 on 2018/7/31.
//  Copyright © 2018年 李浩綸. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet var containerView:UIView!
    //Segue的圖片要先連連看
    @IBOutlet weak var topImageView: UIImageView!
    
    
    //先新建restaurant的圖片檔認證
    var restaurant:Restaurant!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //這段是修改成圖片的內容關鍵
        topImageView.image = UIImage(named: restaurant.image)
        
        
        //這段是把照片模糊
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //改變containerView,縮放為0,等出現時,要動畫產生
        //containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        //改變containerView,縮放為0,還有位址在y=-1000等出現時,要動畫產生
        //動畫都是隨自己希望修改即可
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //當要執行就要有過場動畫
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        /*
        //動畫的段落
         //基礎動畫設定
        UIView.animate(withDuration: 0.3, animations: {
            //要能動畫必須是UIView可以動畫的屬性
            
            //修改為原始1比1大小
            self.containerView.transform = CGAffineTransform.identity
        })
  */
        //進階的動畫設定
        //curveEaseInOut漸進漸出
        //identity在這為還原
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.containerView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        
    }
  
        
        
    
    
}
