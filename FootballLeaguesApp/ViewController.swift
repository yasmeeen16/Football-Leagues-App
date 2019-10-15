//
//  ViewController.swift
//  FootballLeaguesApp
//
//  Created by yasmeen on 10/14/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var LeaguesTable: UITableView!
    //create a refrence to viewModel
    let disposeBag = DisposeBag()
    var LeaguesItems = [LeaguesModel]()
    var cordataItems = [LeaguesCoreDataModel]()
    var NumOfCell = 0
    var connected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        LeaguesTable
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
          self.checkInternet(flag: false, completionHandler:
                    {(internet:Bool) -> Void in
        
                        if (internet)
                        {
                           print("conn")
                           self.connected = true
                            API.GetData(){(error : Error?, success : Bool? , data:[LeaguesModel]?) in
                                if success! {
                                    print("success")
                                    self.LeaguesItems = data!
                                    self.NumOfCell = self.LeaguesItems.count
                                    let ObjectArray : Observable<[LeaguesModel]> = Observable.just(self.LeaguesItems)
                                    ObjectArray.bindTo(self.LeaguesTable.rx.items(cellIdentifier: "cell")){
                                        _, leaguesModel , cell in
                                        if let cellToUse = cell as? LeaguesCell{
                                            
                                            cellToUse.configureCell(league: leaguesModel)
                                        
                                            
                                        }
                                        
                                        }.addDisposableTo(self.disposeBag)
                                    
                                    //self.LeaguesTable.reloadData()
                                }else{
                                    print("failed")
                                }
                            }
                        }else{
                            print("disconn")
                            self.connected = false
                            let fetchRequest : NSFetchRequest<LeaguesCoreDataModel> = LeaguesCoreDataModel.fetchRequest()
                            do{
                                let cordataItems = try PersistenceService.context.fetch(fetchRequest)
                                self.cordataItems = cordataItems
                                print(self.cordataItems.count)
                                 let CoreDataObjectArray : Observable<[LeaguesCoreDataModel]> = Observable.just(cordataItems)
                                CoreDataObjectArray.bindTo(self.LeaguesTable.rx.items(cellIdentifier: "cell")){
                                    _, CoreDataleaguesModel , cell in
                                    if let cellToUse = cell as? LeaguesCell{
                                            cellToUse.id.text = CoreDataleaguesModel.id
                                            cellToUse.name.text = CoreDataleaguesModel.name
                                            cellToUse.startDate.text = CoreDataleaguesModel.start
                                            cellToUse.endDate.text = CoreDataleaguesModel.end
                                        
                                    }
                                    
                                    }.addDisposableTo(self.disposeBag)
                                
                                self.NumOfCell = self.cordataItems.count
                                self.LeaguesTable.reloadData()
                            }catch{
                                
                            }
                            
                        }
        })
    }
   
    func checkInternet(flag:Bool, completionHandler:@escaping (_ internet:Bool) -> Void)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = NSURL(string: "http://www.google.com/")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue.main, completionHandler:
            {(response: URLResponse!, data: Data!, error: Error!) -> Void in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                let rsp = response as! HTTPURLResponse?
                
                completionHandler(rsp?.statusCode == 200)
        })
    }

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}
//extension ViewController : UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return self.NumOfCell
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = LeaguesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesCell
//
//                if (self.connected){
//
//                    let itemViewModel = self.LeaguesItems[indexPath.row]
//                    cell?.configureCell(league: itemViewModel)
//                }else{
//                        cell?.id.text = self.cordataItems[indexPath.row].id
//                        cell?.name.text = self.cordataItems[indexPath.row].name
//                        cell?.startDate.text = self.cordataItems[indexPath.row].start
//                        cell?.endDate.text = self.cordataItems[indexPath.row].end
//                }
////    }
////        })
//
//        return cell!
//    }
//}
//extension ViewController : UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 92
//    }
//}

