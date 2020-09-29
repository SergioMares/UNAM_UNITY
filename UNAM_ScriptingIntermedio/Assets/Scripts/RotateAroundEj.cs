using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateAroundEj : MonoBehaviour
{
    public Transform target;
    // Update is called once per frame
    void Update()
    {
        transform.RotateAround(target.transform.position, //Objetivo sobre el cual rotará
                                Vector3.up,               //Eje sobré el cual rotará
                                20 * Time.deltaTime);     //Velocidad a la cual girará
    }
}
