//
//  AnimeCharacterController.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import UIKit

class AnimeCharacterController: UITableViewController {

    var id : Int? ;
    var name: String?
    var characters = [CharacterData]()
    var selectedCharacter : CharacterData?
    @IBOutlet var spinner : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinner?.startAnimating()
        
        guard let name = self.name else {return} // Vérification de la présence du nom de l'anime
        self.title = "\(name)"
        
            
        //Appel vers l'API
        guard let idString = self.id else {return} // vérification de la présence de l'id
        guard let url = URL(string: "https://api.jikan.moe/v4/anime/\(idString)/characters") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, resp, err in
            if let err = err {
                print("Une erreur est survenue : ", err)
                return
            }
            
            guard let data = data else { return }
            //On decode le JSON selon notre struct model
            guard let characterResponse = try? JSONDecoder().decode(CharacterResponse.self, from: data) else { return }
            self?.characters = characterResponse.data
            print(self?.characters ?? "")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.spinner?.isHidden = true
                self?.spinner?.stopAnimating()
            }
        }
        task.resume()
    }


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Character", for: indexPath)
        let character = characters[indexPath.row]
        
        cell.textLabel?.text = character.character?.name.replacingOccurrences(of: ",", with: "")
        cell.detailTextLabel?.text = "Role : \(character.role)"
        
        if let url = URL(string: character.character?.images.jpg.image_url ?? ""), let data = try? Data(contentsOf: url) {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.characters.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = characters[indexPath.row]
        // Vous pouvez ici effectuer une transition vers un autre écran pour afficher les détails de l'anime sélectionné
        performSegue(withIdentifier: "showCharacterDetail", sender: self)
    }
    
    // MARK: - Navigation
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterDetail" {
            let dest = segue.destination as! CharacterDetailController
            dest.id = selectedCharacter?.character?.mal_id
            dest.name = selectedCharacter?.character?.name
            dest.anime = self.name
        }
    }

}
