using UnityEngine;
public class TestUI : MonoBehaviour
{    
    public void Toggle()
    {
        gameObject.SetActive(!gameObject.activeSelf);
    }
}
