using UnityEngine;
public class test : MonoBehaviour
{
    public GameObject cubo1, cubo2, cubo3, cubo4, cubo5, cubo6;
    public Material colorTrue, colorFalse;
    private bool down, held, up, downB, heldB, upB;
    void Update()
    {
        down = Input.GetKeyDown(KeyCode.Space);
        held = Input.GetKey(KeyCode.Space);
        up = Input.GetKeyUp(KeyCode.Space);

        downB = Input.GetButtonDown("Jump");
        heldB = Input.GetButton("Jump");
        upB = Input.GetButtonUp("Jump");

        if (down)
            cubo1.GetComponent<MeshRenderer>().material = colorTrue;
        else
            cubo1.GetComponent<MeshRenderer>().material = colorFalse;

        if (held)
            cubo2.GetComponent<MeshRenderer>().material = colorTrue;
        else
            cubo2.GetComponent<MeshRenderer>().material = colorFalse;

        if (up)
            cubo3.GetComponent<MeshRenderer>().material = colorTrue;
        else
            cubo3.GetComponent<MeshRenderer>().material = colorFalse;
        /////////////////////////////////////////////////////////////
        if (downB)
            cubo4.GetComponent<MeshRenderer>().material = colorTrue;
        else
            cubo4.GetComponent<MeshRenderer>().material = colorFalse;

        if (heldB)
            cubo5.GetComponent<MeshRenderer>().material = colorTrue;
        else
            cubo5.GetComponent<MeshRenderer>().material = colorFalse;

        if (upB)
            cubo6.GetComponent<MeshRenderer>().material = colorTrue;
        else
            cubo6.GetComponent<MeshRenderer>().material = colorFalse;
    }
}



