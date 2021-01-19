using UnityEngine;

public class InstanciaPrefab : MonoBehaviour
{
    public GameObject prefab;
    // Start is called before the first frame update
    void Start()
    {
        
        //los parámetros que recibe esta funcíón son el prefab a clonar, su posición y rotación
        Instantiate(prefab, transform.position, transform.rotation);
        Instantiate(prefab, new Vector3(2,2,2), transform.rotation);
        
    }
}
