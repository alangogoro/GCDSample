//
//  ViewController.swift
//  GCDSample
//
//  Created by usr on 2020/11/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageView.image = UIImage(systemName: "applelogo")
        
        //simpleQueues()
        
        //queuesWithQoS()
        
        //concurrentQueues()
        
        globalQueue()
        
    }
    
    
    func simpleQueues() {
        
        /* 取一個唯一的 label 給這個佇列
         * 反向的DNS符號(com.appcoda.myqueue)
         * 很容易建立出獨一無二的 label，甚至連 Apple 也建議此寫法
         * 儘管如此，它並不是強制性的規則 */
        let queue = DispatchQueue(label: "com.appcoda.myqueue")
        /* 將在背景運行 */
        /* 直到佇列任務完成前，它將不會繼續主執行緒的迴圈。
         * 這是因為我們使用『同步執行』sync */
        /* queue.sync {
            for i in 0..<10 {
                print("🔴 " ,i)
            }
        } */
        /* 將在背景運行 */
        /* 佇列任務會和主執行緒的迴圈同時進行。
         * 因為我們使用了『非同步執行』async */
        queue.async {
            for i in 0..<10 {
                print("🔴 " ,i)
            }
        }
        
        /* 將在主佇列被執行 */
        for i in 100..<110 {
            print("🅜", i)
        }
        
    }
    
    func queuesWithQoS() {
        /* Quality Of Service（QoS）
         * 佇列優先順序，可以使用這個 enum 安排哪個任務應該優先被執行。
         * 共分成 userInteractive, userInitiated, default,
         *       utility, background, unspecified           */
        
        let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        queue2.async {
            for i in 0..<10 {
                print("🔵", i)
            }
        }
        for i in 1000..<1010 {
            print("🅜", i)
        }
    }
    
    func concurrentQueues() {
        
//        let anotherQueue =
//            DispatchQueue(label: "com.appcda.anotherQueue",
//                          qos: .utility)
        /* DispatchQueue.Attributes 參數
         * 帶入『.concurrent - 並發執行』 */
        let anotherQueue =
            DispatchQueue(label: "com.appcoda.anotherQueue",
                          qos: .unspecified,
                          attributes: .concurrent)
        
        anotherQueue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        anotherQueue.async {
            for i  in 0..<10 {
                print("🔵", i)
            }
        }
        anotherQueue.async {
            for i in 100..<110 {
                print("⚫️", i)
            }
        }
    }
    
    func globalQueue() {
        
        /* 呼叫任意一個佇列 */
        let globalQueue  = DispatchQueue.global()
        let globalQueue_ = DispatchQueue.global(qos: .userInitiated)
        
        let imageURL: URL = URL(string: "https://logos-world.net/wp-content/uploads/2020/04/TikTok-Logo.png")!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("成功下載圖片")
                /* 使用主佇列修改 UI 介面 */
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
        
    }
}
