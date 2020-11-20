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
        simpleQueues()
        
        // queuesWithQoS()
        /*
         concurrentQueues()
         if let queue = inactiveQueue {
            queue.activate()
         }
         */
        // queueWithDelay()
        // fetchImage()
        // useWorkItem()
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
            print("🅼", i)
        }
        
    }
    
}
