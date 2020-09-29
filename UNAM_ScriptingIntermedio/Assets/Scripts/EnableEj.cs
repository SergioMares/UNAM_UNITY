using UnityEngine;

public class EnableEj : MonoBehaviour
{
    public MeshRenderer cubo;

    void Update()
    {
        //Toogle para habilitar/deshabilitar el GameObject
        if(Input.GetKeyUp(KeyCode.Space))
        {
            cubo.enabled = !cubo.enabled;
        }
    }
}
