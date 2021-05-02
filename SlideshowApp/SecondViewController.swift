//
//  secondViewController.swift
//  SlideshowApp
//
//  Created by 唐津 哲也 on 2021/04/25.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate {
    //拡大画像を表示するImageViewを接続
    //@IBOutlet weak var magnifiedView: UIImageView!
    @IBOutlet weak var magnifiedView: UIImageView!
    
    //表示する写真番号をいれる変数を定義
    var slideNumber:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //トップ画面で表示していた画像を拡大表示
        magnifiedView.image = UIImage(named: "image0\(slideNumber).jpg")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
