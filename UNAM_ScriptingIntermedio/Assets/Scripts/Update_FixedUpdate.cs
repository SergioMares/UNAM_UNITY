using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class Update_FixedUpdate : MonoBehaviour
{
    public GameObject obj1;
    public GameObject obj2;

    private void FixedUpdate()
    {
        Debug.Log("fixed van: " + Time.deltaTime);
        obj1.transform.Translate(Vector3.forward * Time.deltaTime);        
    }
    //comentar y descomentar las líneas 21 y 23 para observar distintos comportamientos
    void Update()
    {
        Debug.Log("update van: " + Time.deltaTime);
        //obj2.transform.Translate(Vector3.forward);

        obj2.transform.Translate(Vector3.forward * Time.deltaTime);
    }
}
