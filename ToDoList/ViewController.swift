//
//  ViewController.swift
//  ToDoList
//
//  Created by Alumno on 19/10/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tablaTareas: UITableView!
    
    var listaTareas = [Tarea]()
    
    //Referencia al coredata
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaTareas.delegate = self
        tablaTareas.dataSource = self
        leerTareas()
    } 
 
    
    @IBAction func nuevaTarea(_ sender: UIBarButtonItem) {
        var nombreTarea = UITextField()
        var nombreSubTarea = UITextField()

        
        let alerta = UIAlertController(title: "Nueva", message: "Tarea", preferredStyle: .alert)
        
        let accionAceptar = UIAlertAction(title: "Agregar", style: .default) { (_) in
            let nuevaTarea = Tarea(context: self.contexto)
            nuevaTarea.nombre = nombreTarea.text
            nuevaTarea.sub = nombreSubTarea.text
            nuevaTarea.realizada = false
            
            self.listaTareas.append(nuevaTarea)
            
            self.guardar()
        }
        
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Escribe tu texto aqui.."
            nombreTarea =  textFieldAlert
        }
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "SubTarea"
            nombreSubTarea =  textFieldAlert
        }
        alerta.addAction(accionAceptar)
        
        present(alerta,animated: true)
        /*
        var nombreSub = UITextField()
        
        let alertaSub = UIAlertController(title: "Subtarea", message: "SUBTarea", preferredStyle: .alert)
        
        let accionAceptarSub = UIAlertAction(title: "Agregar", style: .default) { (_) in
            let nuevaTareaSub = Tarea(context: self.contexto)
            nuevaTareaSub.sub = nombreSub.text
            
            self.listaTareas.append(nuevaTareaSub)
            
            self.guardar()
        }
        
        alertaSub.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Escribe tu texto aqui.."
            nombreSub =  textFieldAlert
        }
        alertaSub.addAction(accionAceptarSub)
        
        present(alertaSub,animated: true)
  */
    }
    
    
    //Guarda/actualiza la tabla
    func guardar(){
        do {
            try contexto.save()
        }catch{
            print(error.localizedDescription)
        }
        self.tablaTareas.reloadData()
    }
    
    //lee las tareas
    func leerTareas(){
        let solicitud : NSFetchRequest<Tarea> = Tarea.fetchRequest()
        
        do {
            listaTareas = try contexto.fetch(solicitud)
        } catch{
            print(error.localizedDescription)
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaTareas.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
    
        
        let  tarea = listaTareas[indexPath.row]
        //Operadores ternearios
        //pone los valores de la tarea en la tabla
        celda.detailTextLabel?.text = tarea.sub
        celda.textLabel?.text = tarea.nombre

        /*pone de color la tarea depende si esa hecha o no
        celda.textLabel?.textColor = tarea.realizada ? .black : .blue
        
        celda.detailTextLabel?.text = tarea.realizada ? "Completada" : "Por completar"
        
        //marcar tareas completadas
        celda.accessoryType = tarea.realizada ? .checkmark : .none
        */
        return celda
    }
    
    /*Tabla para poner una paloma a la tarea realizada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Palomar la tarea
        if tablaTareas.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tablaTareas.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tablaTareas.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //Editar en coredata
        listaTareas[indexPath.row].realizada = !listaTareas[indexPath.row].realizada
        
        guardar()
        
        //deselecciona la tarea
        tablaTareas.deselectRow(at: indexPath, animated: true)
    }
 */
    
    //Tabla para eliminar las tareas
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionEliminar = UIContextualAction(style: .normal, title: "Eliminar") { _,_,_  in
            self.contexto.delete(self.listaTareas[indexPath.row])
            self.listaTareas.remove(at: indexPath.row)
            self.guardar()
        }
        accionEliminar.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    
     
}

