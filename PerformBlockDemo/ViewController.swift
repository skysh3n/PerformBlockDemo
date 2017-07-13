//
//  ViewController.swift
//  PerformBlockDemo
//
//  Created by Shen Kai on 2017/7/9.
//  Copyright © 2017年 SkyShen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedObjectContext : NSManagedObjectContext!
    
    var operationQueue : OperationQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operationQueue = OperationQueue()
        // Do any additional setup after loading the view, typically from a nib.
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedObjectContext.performAndWait {
            self.managedObjectContext.performAndWait {
                NSLog("如果没有死锁，就打印我把！！！")
            }
        }
        
        performBlockAndWaitMock {
            self.performBlockAndWaitMock {
                self.performBlockAndWaitMock {
                    self.performBlockAndWaitMock {
                        self.performBlockAndWaitMock {
                            self.performBlockAndWaitMock {
                                NSLog("虽然我不是那个她，但我也是认真的呀，如果没有死锁，就打印我把！！！5")
                            }
                            NSLog("虽然我不是那个她，但我也是认真的呀，如果没有死锁，就打印我把！！！4")
                        }
                        NSLog("虽然我不是那个她，但我也是认真的呀，如果没有死锁，就打印我把！！！3")
                    }
                    NSLog("虽然我不是那个她，但我也是认真的呀，如果没有死锁，就打印我把！！！2")
                }
                NSLog("虽然我不是那个她，但我也是认真的呀，如果没有死锁，就打印我把！！！1")
            }
        }
        
        NSLog("打印完毕")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //模拟实现performBlockAndWait
    func performBlockAndWaitMock(_ block: @escaping () -> Swift.Void) {
        let semaphore = DispatchSemaphore(value: 0)
        operationQueue.addOperation {
            block()
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    
}

