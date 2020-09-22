using UnityEngine;
public class test3 : MonoBehaviour
{
    private test2 test;
    void Start()
    {
        test = GetComponent<test2>();
        test.mostrarDatos();
    }
}


