//
//  AnimeListController.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import UIKit

class AnimeListController: UITableViewController {
    
    //Liste des anime
    var animes = [Anime]()
    var selectedAnime: Anime?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Liste des animes"

        //Appel vers l'API
        guard let url = URL(string: "https://api.jikan.moe/v4/anime") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, resp, err in
            if let err = err {
                print("Une erreur est survenue : ", err)
                return
            }
            
            guard let data = data else { return }
            //On decode le JSON selon notre struct model
            guard let animeResponse = try? JSONDecoder().decode(AnimeResponse.self, from: data) else { return }
            self?.animes = animeResponse.data
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return animes.count
       }

    //On affiche le titre (anime.title) et l'image (anime.image_url)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath)
        let anime = animes[indexPath.row]
        cell.textLabel?.text = anime.title
        cell.detailTextLabel?.text = "\(anime.score)/10"
        
        if let url = URL(string: anime.image_url), let data = try? Data(contentsOf: url) {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }


       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selectedAnime = animes[indexPath.row]
           // Vous pouvez ici effectuer une transition vers un autre écran pour afficher les détails de l'anime sélectionné
           performSegue(withIdentifier: "showCharacters", sender: self)
       }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "showCharacters" {
                let dest = segue.destination as! AnimeCharacterController
                  dest.id = selectedAnime?.mal_id
                  dest.name = selectedAnime?.title
              }
    }

}
