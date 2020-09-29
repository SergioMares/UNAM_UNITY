using UnityEngine;
public class GetComp : MonoBehaviour
{
    public GameObject otroObjeto;
    Material nuevoMaterial, materialActual;
    
    void Start()
    {        
        //Alojamos los materiales en estas variables
        nuevoMaterial = otroObjeto.GetComponent<MeshRenderer>().material;
        materialActual = GetComponent<MeshRenderer>().material;
    }
    void Update()
    {
        //Cambiamos el material desde código dependiendo de las entradas, estos sin la 
        //necesidad de crear los materiales desde el editor
        if(Input.GetKeyDown(KeyCode.Space))
        {
            if (materialActual != nuevoMaterial)
                materialActual.color = Color.cyan;
        }
        if (Input.GetKeyDown(KeyCode.K))
        {
            if (materialActual != nuevoMaterial)
                materialActual.color = nuevoMaterial.color;
        }
        if (Input.GetKeyDown(KeyCode.L))
        {
            if (materialActual != nuevoMaterial)
                nuevoMaterial.color = materialActual.color;
        }
    }
}
