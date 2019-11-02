//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    let apiController = APIController()
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        saveButton.isHidden = true
        
        searchBar.delegate = self
        
        updateViews()
    }
    
    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        
        nameLabel.isHidden = false
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        saveButton.isHidden = false
        
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        abilitiesLabel.text = "\(pokemon.abilities)"
    }
    
}

extension PokemonSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchTerm = searchBar.text?.lowercased(),
        !searchTerm.isEmpty else { return }
        print("Is there something here? \(searchTerm)")
        


        apiController.fetchAPokemon(searchTerm: searchTerm) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            } catch {
                print("There's an error - no Pikachu for you!")
                return
            }
        }
    }
}

