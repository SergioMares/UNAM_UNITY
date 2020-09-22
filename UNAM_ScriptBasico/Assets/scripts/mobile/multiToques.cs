using UnityEngine.UI;
using UnityEngine;
public class multiToques : MonoBehaviour
{
    public Text multiTouchInfoDisplay;
    private int maxTapCount = 0;
    private string multiTouchInfo;
    private Touch theTouch;
    void Update()
    {
        //multiTouchInfo = string.Format("Max tap count: {0}\n", maxTapCount);
        multiTouchInfo = "Max tap count: " + maxTapCount + "\n";
        if (Input.touchCount > 0)
        {
            for (int i = 0; i < Input.touchCount; i++)
            {
                theTouch = Input.GetTouch(i);           
                multiTouchInfo +=
                    "Touch:" + i.ToString() +
                    " -Position:" + theTouch.position +
                    " -Tap Count: " + theTouch.tapCount +
                    " -Finger ID: " + theTouch.fingerId +
                    "Radius: " + theTouch.radius;            
                if (theTouch.tapCount > maxTapCount)
                {
                    maxTapCount = theTouch.tapCount;
                }
            }
        }
        multiTouchInfoDisplay.text = multiTouchInfo;        
    }
}
