using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreadorCoches : MonoBehaviour
{
    //Arreglos con las posiciónes iniciales de los coches añ arranque del programa
    public Vector3[] posIniciales1 = new Vector3[4];
    public Vector3[] posIniciales2 = new Vector3[4];

    //Arreglos con las posiciónes iniciales de los coches mientras el programa está en ejecución
    public Vector3[] posBorde1 = new Vector3[3];
    public Vector3[] posBorde2= new Vector3[3];

    //Lista de coches
    public List<GameObject> autos1= new List<GameObject>();
    public List<GameObject> autos2 = new List<GameObject>();

    //Lista de materiales de los coches
    public List<Material> pintura = new List<Material>();
    // Game Object del chasis
    public GameObject chasis;

    // Valores límite de la carretera
    public float limite1 = 7.5f;
    public float limite2 = -95.5f;

    // Start is called before the first frame update
    void Start()
    {
        posIniciales1[0] = new Vector3(-325.23f, 70.498f, -81.32f);
        posIniciales1[1] = new Vector3(-318.61f, 70.498f, -69.3f);
        posIniciales1[2] = new Vector3(-321.7f, 70.498f, -59.5f);
        posIniciales1[3] = new Vector3(-325.2f, 70.498f, -46.2f);

        posIniciales2[0] = new Vector3(-332.28f, 70.498f, -31.1f);
        posIniciales2[1] = new Vector3(-329.56f, 70.498f, -49.5f);
        posIniciales2[2] = new Vector3(-335.32f, 70.498f, -69.21f);
        posIniciales2[3] = new Vector3(-332.4f, 70.498f, -48.59f);

        posBorde1[0] = new Vector3(-325.15f, 70.498f, -91.64f);
        posBorde1[1] = new Vector3(-322.12f, 70.498f, -91.64f);
        posBorde1[2] = new Vector3(-318.74f, 70.498f, -91.64f);

        posBorde2[0] = new Vector3(-329.08f, 70.498f, 4.7f);
        posBorde2[1] = new Vector3(-332.39f, 70.498f, 4.7f);
        posBorde2[2] = new Vector3(-335.59f, 70.498f, 4.7f);

        //prefab = Instantiate(Resources.Load("AutoPlantilla"), Vector3.zero, Quaternion.identity) as GameObject;
        //GameObject pNewObject = (GameObject)GameObject.Instantiate(prefab, Vector3.zero, Quaternion.identity);

        for (int i = 0; i < 4; i++)
        {
            //Se crean los autos en ambos sentidos

                autos1.Add(Instantiate(Resources.Load("AutoPlantilla"), posIniciales1[i], Quaternion.Euler(0, 0, 0)) as GameObject);
                autos2.Add(Instantiate(Resources.Load("AutoPlantilla"), posIniciales2[i], Quaternion.Euler(0, 180, 0)) as GameObject);
            
        }


        pintura.Add(Instantiate(Resources.Load("Materiales/PinturaAzul", typeof(Material)) as Material));
        pintura.Add(Instantiate(Resources.Load("Materiales/PinturaAmarilla", typeof(Material)) as Material));
        pintura.Add(Instantiate(Resources.Load("Materiales/PinturaRoja", typeof(Material)) as Material));
        pintura.Add(Instantiate(Resources.Load("Materiales/PinturaVerde", typeof(Material)) as Material));
        pintura.Add(Instantiate(Resources.Load("Materiales/PinturaNegra", typeof(Material)) as Material));

    }

    // Update is called once per frame
    void Update()
    {
        RemplazarCoches();
    }

    void RemplazarCoches()
    {
        for (int i = 0; i < autos1.Count; i++)
        {
            //Validar si el choche superó el limite de la carretera
            if (autos1[i].transform.position.z > limite1 )
            {
                Destroy(autos1[i]);
                autos1.RemoveAt(i);
                
                autos1.Add(Instantiate(Resources.Load("AutoPlantilla"), posBorde1[Random.Range(0, 2)], Quaternion.Euler(0, 0, 0)) as GameObject);
            }
        }

        for (int i = 0; i < autos2.Count; i++)
        {
            //Validar si el coche superó el limite de la carretera (sentido contrario)
            if (autos2[i].transform.position.z < limite2)
            {
                Destroy(autos2[i]);
                autos2.RemoveAt(i);              
                
                autos2.Add(Instantiate(Resources.Load("AutoPlantilla"), posBorde2[Random.Range(0, 2)], Quaternion.Euler(0, 180, 0)) as GameObject);
            }
        }
    }
}
