using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActivateEj : MonoBehaviour
{
    public GameObject cubo;
    bool activo = true;

    // Update is called once per frame
    void Update()
    {
        //Toogle para Activar/Desactivar un GameObject
        if(Input.GetKeyUp(KeyCode.Space))
        {
            cubo.SetActive(!activo);
            activo = !activo;
        }
    }
}
