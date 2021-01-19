using UnityEngine;
using System.Collections;

public class CreandoPrimitivas : MonoBehaviour
{
    public GameObject cubo;
    public GameObject prefab;
    
    void Start()
    {
        //GameObject plane = GameObject.CreatePrimitive(PrimitiveType.Plane);
        //GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);

        cubo.SetActive(false);
        
        

        Instantiate(prefab, transform.position, transform.rotation);
    }
}