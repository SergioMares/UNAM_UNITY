using UnityEngine;

public class Translate_Rotate : MonoBehaviour
{
    public float moveSpeed = 10f;
    public float turnSpeed = 50f;

    void Update()
    {
        //Controlaremos el GameObject en el que esté alojado este script dependiendo
        //de las entradas de teclado que demos
        if (Input.GetKey(KeyCode.UpArrow))
            transform.Translate(Vector3.forward * moveSpeed * Time.deltaTime);
        if (Input.GetKey(KeyCode.DownArrow))
            transform.Translate(-Vector3.forward * moveSpeed * Time.deltaTime);
        if (Input.GetKey(KeyCode.LeftArrow))
            transform.Rotate(Vector3.up, -turnSpeed * Time.deltaTime);
        if (Input.GetKey(KeyCode.RightArrow))
            transform.Rotate(Vector3.up, turnSpeed * Time.deltaTime);
    }
}
