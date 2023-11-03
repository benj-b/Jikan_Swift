//
//  AnimeCharacterDetailController.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import UIKit

class CharacterDetailController: ViewController {
    
    var name: String?
    var id : Int?
    var character : CharacterDetails?
    var anime : String?
    
    @IBOutlet var pageTitle : UILabel?
    @IBOutlet var pic : UIImageView?
    @IBOutlet var characterName : UILabel?
    @IBOutlet var animeName : UILabel?
    @IBOutlet var kanjiName : UILabel?
    @IBOutlet var nicknames : UILabel?
    @IBOutlet var desc : UITextView?
    @IBOutlet var spinner : UIActivityIndicatorView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pour desactiver la modification du texte
        self.desc?.isEditable = false
        // Pour le scroll
        self.desc?.isScrollEnabled = true
        
        guard let id = self.id else {return}
        
        //spinner
        self.spinner?.startAnimating()
        
        //Appel vers l'API
        guard let url = URL(string: "https://api.jikan.moe/v4/characters/\(id)") else { return}
    
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, resp, err in
            if let err = err {
                print("Une erreur est survenue : ", err)
                return
            }
            
            
            
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            
            //On decode le JSON selon notre struct model
            guard let characterDetailResponse = try? JSONDecoder().decode(CharacterDetailResponse.self, from: data) else { return }
            self?.character = characterDetailResponse.data

            // On update les infos de maniere asynchrone
            DispatchQueue.main.async {
                self?.updateInfo()
            }
        }
        task.resume()
    }
    
    // Fonction qui met à jour les textes des elements graphiques
    func updateInfo(){
        self.pageTitle?.text = self.name?.replacingOccurrences(of: ",", with: "")
        self.characterName?.text = character?.name
        self.kanjiName?.text = character?.name_kanji ?? ""
        self.animeName?.text = "Anime : \(self.anime ?? "")"
        let nickname = character?.nicknames.joined(separator: "\n")
        if nickname != "" {
            self.nicknames?.text = "Surnom(s) : \(nickname ?? "")"
        }
        else {self.nicknames?.text = ""}
        
        self.desc?.text = character?.about ?? "On n'a pas plus d'info mais ca doit être un super personnage"
        guard let imageUrl = character?.images.jpg.image_url else { return }
        // ici on charge de manière synchrone les images, c'est pas opti mais on a pas eu le temps de faire mieux
        if let url = URL(string: imageUrl), let data = try? Data(contentsOf: url) {
            self.pic?.image = UIImage(data: data)
        }
        
        self.spinner?.stopAnimating()
        self.spinner?.isHidden = true
    
        
    }
    
    // MARK: - Navigation

}
