//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 唐津 哲也 on 2021/04/24.
//
import UIKit

class ViewController: UIViewController {
    //変数timerをオプショナルTimer型で定義
    var timer:Timer!
    //imageViewerを接続
    @IBOutlet weak var slide: UIImageView!
    //再生ボタン接続（表示の切替用）
    @IBOutlet weak var playButton: UIButton!
    //進むボタンを接続（表示の切替用）
    @IBOutlet weak var nextButton: UIButton!
    //戻るボタンを接続（表示の切替用）
    @IBOutlet weak var backButton: UIButton!
    
    //表示する複数の写真を格納する配列を定義
    var imageArray:[UIImage] = []
    //現在表示している写真番号を格納する変数を定義
    var index:Int = 0
    //写真枚数をカウントする変数を定義
    var numberOfSheets:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    //--------------------表示する複数の写真を配列に読み込む------------------------
        while let image = UIImage(named: "image0\(imageArray.count).jpg") {
            //print(imageArray.count)
            imageArray.append(image)
        }
        //imageArrayに格納された写真枚数の合計を、numberOfSheetsに格納しておく。
        numberOfSheets = imageArray.count - 1
        //print(numberOfSheets)
        //最初の一枚をslide(UIImageView)に表示する
        slide.image = imageArray[index]
    }

    //スライドショーを再生する関数を定義
    @objc func updateSlide(_ timer: Timer) {
        //numberOfSheetよりindexが小さい-> index+=1して「次の」写真を表示
        if index < numberOfSheets {
            index += 1
            slide.image = imageArray[index]
        //numberOfSheetsがindexと同じ-> indexを０に戻して、最初の写真を表示
        } else if index == numberOfSheets {
            index = 0
            slide.image = imageArray[index]
        }
    }
        
    @IBAction func backToTop (_ segue: UIStoryboardSegue) {
        //secondViewから戻る際に呼ばれる
    }
    
    //再生ボタンが押された時の処理
    @IBAction func play(_ sender: Any) {
        //スライドが停止中ならば
        if self.timer == nil {
            //現在の写真からスライド再生開始
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateSlide(_:)), userInfo: nil, repeats: true)
            //ボタンの表示を「停止」に変える
            playButton.setTitle("停止", for: .normal)
            //「進む」「戻る」ボタンを無効にする
            nextButton.isEnabled = false
            backButton.isEnabled = false

        //スライドが再生中ならば
        } else if self.timer != nil {
            //現在の写真でスライドを停止
            self.timer.invalidate()
            self.timer = nil
            //ボタンの表示を「再生」にもどす
            playButton.setTitle("再生", for: .normal)
            //「進む」「戻る」ボタンを有効にする
            nextButton.isEnabled = true
            backButton.isEnabled = true
        }
    }

    //進むボタンが押された時の処理
    @IBAction func next(_ sender: Any) {
        //スライド再生中でなければ次の写真を表示
        if self.timer == nil {
            //numberOfSheetよりindexが小さい-> index+=1して「次の」写真を表示
            if index < numberOfSheets {
                index += 1
                slide.image = imageArray[index]
            //numberOfSheetsがindexと同じ-> indexを０に戻して、最初の写真を表示
            } else if index == numberOfSheets {
                index = 0
                slide.image = imageArray[index]
            }
        }
    }
    //戻るボタンが押された時の処理
    @IBAction func back(_ sender: Any) {
        //スライド再生中でなければ//前の写真を表示
        if self.timer == nil {
            //indexが０より大きい-> index-=1して「前の」写真を表示
            if index <= numberOfSheets && index > 0 {
                index -= 1
                slide.image = imageArray[index]
            //numberOfSheetsがindexと同じ-> indexをimageArrayに戻して、最後の写真を表示
            } else if index == 0 {
                index = numberOfSheets
                slide.image = imageArray[index]
            }
        }
    }
    
    //セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //遷移先SecondViewControllerを取得
        let secondView = segue.destination as! SecondViewController
        //値を設定
        secondView.slideNumber = index
        //スライドショーが再生中ならば、再生を止める
        if self.timer != nil {
            //現在の写真でスライドを停止
            self.timer.invalidate()
            self.timer = nil
            //ボタンの表示を「再生」にもどす
            playButton.setTitle("再生", for: .normal)
            //「進む」「戻る」ボタンを有効にする
            nextButton.isEnabled = true
            backButton.isEnabled = true
        }
    }
    
}

