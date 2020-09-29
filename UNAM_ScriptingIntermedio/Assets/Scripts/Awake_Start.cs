using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Awake_Start : MonoBehaviour
{
    //Awake puede entrar aún cuando el script está deshabilitado, pero al menos el 
    //GameObject donde se aloja debe estar habilitado
    private void Awake()
    {
        Debug.Log("Entró Awake");
    }


    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("Entró Start");   
    }
}
