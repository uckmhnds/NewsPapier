//
//  DataPersistence.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 16.10.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager{

    enum DatabaseError: Error{
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }

    static let shared = DataPersistenceManager()

    func downloadTitleWith(model: News, completion: @escaping (Result<Void, Error>) -> Void){

        // A reference to the AppDelegate

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext

        // Create a TitleItem under context supervision

        let item = NewsItem(context: context)

//        item.id  = Int64(model.id)
//        item.original_title = model.original_title
//        item.original_name = model.original_name
//        item.overview = model.overview
//        item.poster_path = model.poster_path
//        item.media_type = model.media_type
//        item.release_date = model.release_date
//        item.vote_average = model.vote_average
//        item.vote_count = Int64(model.vote_count)

        do{
            try context.save()
            // Success takes Void so that we pass just () which is a Void
            completion(.success(()))
        }catch{
//            print(error.localizedDescription)
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
//
//    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void){
//
//        // A reference to the AppDelegate
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        let request: NSFetchRequest<TitleItem>  = TitleItem.fetchRequest()
//
//        do{
//            let titles = try context.fetch(request)
//            completion(.success(titles))
//        }catch{
//            completion(.failure(DatabaseError.failedToFetchData))
//        }
//    }
//
//    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void){
//
//        // A reference to the AppDelegate
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        // Asking the database manager to delete a certain object
//        context.delete(model)
//
//        do{
//            try context.save()
//            completion(.success(()))
//
//        }catch{
//            completion(.failure(DatabaseError.failedToDeleteData))
//        }
//    }
//
}

